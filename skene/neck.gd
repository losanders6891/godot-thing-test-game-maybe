extends Node3D
var yLockLow = -90
var yLockHigh = 90
@export var _rotation: Vector3 
@export var playercont: 

func updateCameraRotation(input: Vector3): 
	_rotation.x = input.y
	_rotation.y = input.x
	_rotation.x = clamp(_rotation.x,deg_to_rad(yLockLow),deg_to_rad(yLockHigh))
	
	var playerRotation = Vector3(0.0,_rotation.y,0.0)
	var cameraRotation = Vector3(_rotation.x,0.0,0.0)
	
	transform.basis = basis.from_euler(cameraRotation)
	
	
	rotation.z = 0.0 
	
func updateCameraHeight(delta:) -> void:
	position.y = clampf(position.y,0, 0)
