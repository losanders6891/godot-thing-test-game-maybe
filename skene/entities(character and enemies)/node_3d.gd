class_name Scanner extends Node3D


func lookAtTarget(tar: CharacterBody3D) -> void:

	rotation.y = tar.global_rotation.y
