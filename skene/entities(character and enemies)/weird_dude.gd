extends CharacterBody3D
@export var target: CharacterBody3D
var speed = 5


func _physics_process(delta: float) -> void:
	var dir = (target.position - position).normalized()
	rotate_toward(position.x, dir.x, 1.0)
	velocity = dir * speed
	
	move_and_slide()
