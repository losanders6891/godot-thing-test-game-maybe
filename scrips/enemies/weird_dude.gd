class_name enemy1 extends CharacterBody3D
@export var target: CharacterBody3D
@onready var scanner: Scanner = $thing
@onready var detector: Detector = $"thing/objectDetect?"
var speed = 5
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
	var isObstructed = detector.checkForObstruction()
	
	rotation.y = lerp_angle(rotation.y,rot.y,0.2)
	var movementVelocity = dir * speed
	velocity = Vector3(movementVelocity.x,velocity.y,movementVelocity.z)
	#TODO: add jump check and jump
	if not is_on_floor():
		velocity.y -= gravity
	
	move_and_slide()
	
