class_name PathScanner extends Node3D
@export var detector: Detector
@export var jumpable: HeightCheck

##precondition: current route is obstructed 
## tries to find and return a route that is unobstructed
func findRoute(currentRot: float) -> float:
	rotation_degrees.y += 5
	var temp = rotation.y
	if !detector.checkForObstruction() || jumpable.jumpCheck():
		rotation.y = currentRot
		return temp
	else:
		return currentRot
