extends CharacterBody3D
var movespeed = 7
var gravity = 15
var jumpspeed = 20 
var dashspeed = 30

@onready var neck := $Neck 
@onready var camera := $Neck/Camera3D

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x *0.01)
			camera.rotate_x(-event.relative.y *0.01)
			camera.rotation.x = clamp(camera.rotation.x,deg_to_rad(-30),deg_to_rad(60))
		
#start the main physics loop
func _physics_process(delta):
	#initialize and reset direction
	var relative_direction = Vector3.ZERO
	
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
	
	
	
	
		
		

		
	
	
	
	
	
