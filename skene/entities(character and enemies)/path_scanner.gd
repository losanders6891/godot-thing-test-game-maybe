class_name PathScanner extends Node3D
@export var detector: Detector
@export var jumpable: HeightCheck

##precondition: current route is obstructed 
## tries to find and return a route that is unobstructed
func findRoute(currentDir: Vector3) -> Vector3:
	rotation_degrees.y += 5
	var temp = rotation.y
	if !detector.checkForObstruction() || jumpable.jumpCheck():
		print(currentDir.rotated(Vector3(0.0,0.0,0.0).normalized(),temp).y)
		return currentDir.rotated(Vector3(0.0,0.0,0.0).normalized(),temp)
	else:
		print(temp)
		return currentDir
