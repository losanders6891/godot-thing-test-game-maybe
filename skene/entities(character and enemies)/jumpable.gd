class_name HeightCheck extends RayCast3D

## checks if the enemy can jump over an object
func jumpCheck() -> bool:
	force_raycast_update()
	if is_colliding():
		return false
	else: return true
