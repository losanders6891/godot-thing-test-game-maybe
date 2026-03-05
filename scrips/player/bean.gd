class_name playerController extends CharacterBody3D
var movespeed = 12
var gravity = 0.8
var jumpspeed = 20 
var dashspeed = 30
var acceleration = 0.5
var deceleration = 0.75
var movementVelocity : Vector3 = Vector3.ZERO
@onready var aimRay = $Neck/Camera3D/Aim
var pistolParticle = preload("res://particles/placeholder_particles.tscn")
##currently just checks if the raycas is colliding and deals damage
func shoot() -> void:
	aimRay.force_raycast_update()
	if aimRay.is_colliding():
		var collision = aimRay.get_collision_point()
		var effect : GPUParticles3D = pistolParticle.instantiate() 
		effect.position = collision
		effect.look_at(position)
		add_child(effect)
		var target: Object = aimRay.get_collider()
		if target.is_class("CharacterBody3D"):
			if target.has_method("hit"):
				target.hit(10)
		
## rotates player
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
	
	if direction:
		currentVelocity = lerp(currentVelocity,Vector2(direction.x,direction.z) * movespeed,acceleration)
	else:
		currentVelocity = currentVelocity.move_toward(Vector2.ZERO,deceleration)
	
	movementVelocity = Vector3(currentVelocity.x,velocity.y,currentVelocity.y)
	
	velocity = movementVelocity
	
	move_and_slide()
