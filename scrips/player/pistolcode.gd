extends Node3D
@onready var player : playerController = $player
@export var projectile : PackedScene
@onready var main = $main
##shoots a bullet dealing 30 damage
func shoot():
	#TODO: use move and collide for hitscan and find how to create ray stopping at enemy or wall
	
	
	


func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("shoot")):
		shoot()
		
	
	
