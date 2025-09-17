extends CharacterBody3D
var movespeed = 7
var gravity = 15
var jumpspeed = 20
var dashspeed = 30


#start the main physics loop
func _physics_process(delta):
	#initialize and reset direction
	var direction = Vector3.ZERO
	
	if Input.is_action_pressed("walk-forward"):
		direction.z -= 1
	if Input.is_action_pressed("walk-backward"):
		direction.z += 1
	if Input.is_action_pressed("strafe-left"):
		direction.x -= 1
	if Input.is_action_pressed("strafe-right"):
		direction.x += 1
	#normalize movement
	if direction != Vector3.ZERO:
		direction = direction.normalized()
	
		
		

		
	
	
	
	
	
