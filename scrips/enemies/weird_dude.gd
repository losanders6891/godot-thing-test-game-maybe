class_name enemy1 extends CharacterBody3D
@export var target: CharacterBody3D
@onready var scanner: Scanner = $thing
@onready var detector: Detector = $"thing/objectDetect?"
@onready var pathDetect: PathScanner = $pathScanner
@onready var jumpable: HeightCheck = $pathScanner/jumpable
var speed = 5
var jumpSpeed = 20
@onready var rot = target.global_rotation
var gravity = 0.8
@export var health: int = 30
func jump():
	velocity.y += jumpSpeed
func hit(damage: int)-> void:
	health -= damage

	
func _physics_process(_delta: float) -> void:
	var dirToTarget = (target.position - position).normalized()
	
	var dir = Vector3(dirToTarget.x,0.0,dirToTarget.z)
	
	if health <= 0:
		queue_free()
	
	scanner.rotation.y = rot.y
	
	
	var isObstructed = detector.checkForObstruction()
	if  isObstructed:
		
		
		if!jumpable.jumpCheck():
			dir = Vector3(0.0, 0.0, 1.0)
		#mostly working
		# has to be facing object
		#rot.y = 
		if jumpable.jumpCheck(): 
			if is_on_floor():
				jump()
	else:
		#objectively wrong but i dont know how to fix
		#rot.y += dir.angle_to(target.position): add to model as script?
		var pos2D = Vector3(position.x,0.0,position.z)
		rot.y = pos2D.angle_to(Vector3(target.position.x,0.0,target.position.z))
	
	#still wrong
	rotate_y(rot.y)
	var movementVelocity = dir * speed
	velocity = Vector3(movementVelocity.x,velocity.y,movementVelocity.z)
	
	if not is_on_floor():
		velocity.y -= gravity
	
	move_and_slide()
	
