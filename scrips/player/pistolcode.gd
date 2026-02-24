extends Node3D
var projectile = preload("res://skene/projectiles/pistolbullet_test.tscn")
##shoots a bullet dealing 30 damage
func shoot():
	#TODO: create and instantiate projectile or find out how to do hitscan
	projectile.instantiate()
	add_child(projectile)



func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("shoot")):
		shoot()
		
	
	
