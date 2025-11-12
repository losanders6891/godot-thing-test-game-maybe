class_name playerController extends CharacterBody3D
var movespeed = 7
var gravity = 15
var jumpspeed = 20 
var dashspeed = 30

func update_rotation(inputRotation) -> void:
	global_transform.basis = Basis.from_euler(inputRotation)
#start the main physics loop
func _physics_process(delta):
	#initialize and reset direction
	var relative_direction = Vector3.ZERO
	if Input.is_action_pressed("noLock"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	#XZ = ground plane
	if Input.is_action_pressed("walk-forward"):
		relative_direction.z -= 1
	if Input.is_action_pressed("walk-backward"):
		relative_direction.z += 1
	if Input.is_action_pressed("strafe-left"):
		relative_direction.x -= 1
	if Input.is_action_pressed("strafe-right"):
		relative_direction.x += 1
	
	if Input.is_action_pressed("jump") and  is_on_floor():
		velocity.y += jumpspeed
	if not is_on_floor():
		velocity.y -= gravity
	#normalize movement
	if relative_direction != Vector3.ZERO:
		relative_direction = relative_direction.normalized() 
		
