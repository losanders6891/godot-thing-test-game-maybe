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
	#always true
	if  isObstructed:
		print(isObstructed)
		var tar = detector.get_collision_point()
		var Tar2D = Vector2(tar.x,tar.z)
		#never true
		if!jumpable.jumpCheck():
			print("1: " + dir)
			dir = pathDetect.findRoute(dir)
			print("2: " + dir)
			scanner.rotation.y = rot.y
			isObstructed = detector.checkForObstruction()
		#mostly working
		if jumpable.jumpCheck() && Tar2D.distance_to(Vector2(position.x,position.z)) < 2: 
			if is_on_floor():
				jump()
	else:
		rot = target.global_rotation
	rotation.y = lerp_angle(rotation.y,rot.y,0.4)
	var movementVelocity = dir * speed
	velocity = Vector3(movementVelocity.x,velocity.y,movementVelocity.z)
	
	if not is_on_floor():
		velocity.y -= gravity
	
	move_and_slide()
	
