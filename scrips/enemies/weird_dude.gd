class_name enemy1 extends CharacterBody3D
@export var target: CharacterBody3D
@onready var scanner: Scanner = $thing
@onready var detector: Detector = $"thing/objectDetect?"
@onready var pathDetect: PathScanner = $pathScanner
@onready var jumpable: HeightCheck = $pathScanner/jumpable
var speed = 5
var jumpSpeed = 20
var gravity = 0.8
@export var health: int = 10
func jump():
	velocity.y += jumpSpeed
func hit(damage: int)-> void:
	health -= damage

func _physics_process(_delta: float) -> void:
	var dirToTarget = (target.position - position).normalized()
	var lookTar = Vector3(0.0, position.y, 0.0)
	var dir = Vector3(dirToTarget.x,0.0,dirToTarget.z)
	
	if health <= 0:
		queue_free()
	
	scanner.rotation.y = scanner.position.angle_to(target.position)
	pathDetect.rotation.y = pathDetect.position.angle_to(target.position)
	var isObstructed = detector.checkForObstruction()
	if  isObstructed:
		if!jumpable.jumpCheck():
			position.x += 20.0
			print("kill self")
		if jumpable.jumpCheck(): 
			if is_on_floor():
				jump()
	else:
		lookTar = Vector3(target.global_transform.origin.x, position.y, target.global_transform.origin.z)

	look_at(lookTar)
	var movementVelocity = dir * speed
	velocity = Vector3(movementVelocity.x,velocity.y,movementVelocity.z)
	
	if not is_on_floor():
		velocity.y -= gravity
	
	move_and_slide()
	
