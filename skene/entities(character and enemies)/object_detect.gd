class_name Detector extends RayCast3D

func checkForObstruction() -> bool:
	if !is_colliding():
		return false
	elif get_collision_mask_value(1):
		return false
	else: 
		return true
