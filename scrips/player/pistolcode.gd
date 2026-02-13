extends Node3D

##shoots a bullet dealing 30 damage
func shoot():
	#TODO: create and instantiate projectile or find out how to do hitscan



func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("shoot")):
		shoot()
	
	
