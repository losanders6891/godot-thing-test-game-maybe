extends RayCast3D

func hitscan():
	force_raycast_update
	var target = get_collider()
	if target.is_class("enemy1"):
		target.call("hit")
