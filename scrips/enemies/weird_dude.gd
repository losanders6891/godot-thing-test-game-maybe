extends CharacterBody3D
@export var target: CharacterBody3D
var speed = 5
@export var health: int = 30

## gets damaged when shot
func hit(type: int):
	if type == 0 :
		health -= 10
	
	if health <= 0:
		queue_free()

func _physics_process(_delta: float) -> void:
	var dir = (target.position - position).normalized()
	var rot = target.global_rotation
	
	if health <= 0:
		queue_free()
	
	rotation.y = lerp_angle(rotation.y,rot.y,0.2)
	velocity = dir * speed
	
	move_and_slide()
