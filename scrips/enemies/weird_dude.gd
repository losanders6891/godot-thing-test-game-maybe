class_name enemy1 extends CharacterBody3D
@export var target: CharacterBody3D
@onready var scanner: Scanner = $thing
@onready var detector: Detector = $"thing/objectDetect?"
@onready var pathDetect: PathScanner = $pathScanner
@onready var jumpable: HeightCheck = $pathScanner/jumpable
var speed = 10
var jumpSpeed = 20
var gravity = 0.8
@export var health: int = 30
func jump():
	velocity.y += jumpSpeed
func hit(damage: int)-> void:
	health -= damage

	
func _physics_process(_delta: float) -> void:
	var dirToTarget = (target.position - position).normalized()
	var rot = target.global_rotation
	var dir = Vector3(dirToTarget.x,0.0,dirToTarget.z)
	
	if health <= 0:
		queue_free()
	
	scanner.lookAtTarget(target)
	
	# not working currently
	var isObstructed = detector.checkForObstruction()
	print(jumpable.jumpCheck())
	if isObstructed && !jumpable.jumpCheck():
		rot.y = pathDetect.findRoute(rot.y)
	if isObstructed && jumpable.jumpCheck():
		if is_on_floor():
			jump()

	rotation.y = lerp_angle(rotation.y,rot.y,0.2)
	var movementVelocity = dir * speed
	velocity = Vector3(movementVelocity.x,velocity.y,movementVelocity.z)
	
	if not is_on_floor():
		velocity.y -= gravity
	
	move_and_slide()
	
