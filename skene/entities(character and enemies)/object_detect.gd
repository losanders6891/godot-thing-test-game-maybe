class_name Detector extends RayCast3D
var e : RayCast3D ## just for checking available functions

func checkForObstruction() -> bool:
	force_raycast_update()
	if !is_colliding():
		return false
	else: 
		return true
