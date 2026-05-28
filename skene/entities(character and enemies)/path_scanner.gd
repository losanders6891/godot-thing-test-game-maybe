class_name PathScanner extends Node3D
@export var detector: Detector
@export var jumpable: HeightCheck


func findRouteRot(currentRot: float) -> float:
	var temp = rotation.y
	if !detector.checkForObstruction() || jumpable.jumpCheck():
		return temp
	else:
		return currentRot

##precondition: current route is obstructed 
## tries to find and return a route that is unobstructed
func findRouteDir(currentDir: Vector3) -> Vector3:
	rotation_degrees.y += 5
	var temp = rotation.y
	if !detector.checkForObstruction() || jumpable.jumpCheck():
		return currentDir.rotated(currentDir,temp)
	else:
		return currentDir
