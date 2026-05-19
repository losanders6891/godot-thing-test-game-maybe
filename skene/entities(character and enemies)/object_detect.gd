class_name Detector extends RayCast3D

func checkForObstruction() -> bool:
	force_raycast_update()
	if !is_colliding():
		return false
	else: 
		return true
