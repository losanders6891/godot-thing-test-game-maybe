class_name playerController extends CharacterBody3D
var movespeed = 18
var gravity = 0.8
var jumpspeed = 20 
var acceleration = 0.6
var deceleration = 0.85
var movementVelocity : Vector3 = Vector3.ZERO
@onready var aimRay = $Neck/Camera3D/Aim # maybe export this so it can be changed?
@onready var dashTimer: Timer = $Components/DashTime #bad code stuff, remove when code is debugged
@onready var dashCD: Timer = $Components/DashCD
var pistolParticle = preload("res://particles/placeholder_particles.tscn") # no idea if this is necessary
var dashDir: Vector3

##currently just checks if the raycast is colliding and deals damage
#particle efffects in progress
func shoot() -> void:
	aimRay.force_raycast_update()
	if aimRay.is_colliding():
		var collision = aimRay.get_collision_point()
		var effect : GPUParticles3D = pistolParticle.instantiate() 
		effect.position = collision
		#TODO: make particle effects visible consistently.
		effect.look_at_from_position(effect.position, $Neck.position)
		add_child(effect)
		effect.restart()
		effect.queue_free()
		remove_child(effect)
		var target: Object = aimRay.get_collider()
		if target.is_class("CharacterBody3D"):
			if target.has_method("hit"):
				target.hit(10)
		

func update_rotation(inputRotation) -> void:
	global_transform.basis = Basis.from_euler(inputRotation)
# start the main physics loop
func _physics_process(_delta):
	#initialize and reset direction
	if Input.is_action_pressed("noLock"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		#jumps and falls
	if Input.is_action_pressed("jump") and  is_on_floor():
		velocity.y += jumpspeed
	if not is_on_floor():
		velocity.y -= gravity
	if Input.is_action_just_pressed("shoot"):
		shoot()
	
	
	
	#XZ = ground plane
	var inputDir = Input.get_vector("strafe-left","walk-backward","walk-forward","strafe-right")
	var currentVelocity = Vector2(movementVelocity.x, movementVelocity.z)
	var direction = (transform.basis * Vector3(inputDir.x,0,inputDir.y)).normalized()
	#TODO: remove magic numbers here
	if direction:
		if Input.is_action_just_pressed("dash") && dashCD.is_stopped():
			dashTimer.start()
			dashDir = direction
			dashCD.start()
	if !dashTimer.is_stopped():
			movespeed = 100
			direction = dashDir
			acceleration = 0.8
	else:
		movespeed = move_toward(movespeed, 18, 8)
		if movespeed > 18:
			deceleration = 0.95
		else: 
			deceleration = 0.8
		acceleration = 0.5
	
	if direction:
		currentVelocity = lerp(currentVelocity,Vector2(direction.x,direction.z) * movespeed,acceleration)
	else:
		currentVelocity = currentVelocity.move_toward(Vector2.ZERO,deceleration)
	
	movementVelocity = Vector3(currentVelocity.x,velocity.y,currentVelocity.y)
	
	velocity = movementVelocity
	
	move_and_slide()
