class_name neck extends Node3D
var yLockLow = -90
var yLockHigh = 90
@export var _rotation: Vector3
@export_category("references")
@export var player: playerController
@export var mouseCaptureComponent: mouseCapture

func updateCameraRotation(input: Vector3) -> void: 
	_rotation.x = input.y
	_rotation.y = input.x
	_rotation.x = clamp(_rotation.x,deg_to_rad(yLockLow),deg_to_rad(yLockHigh))
	
	var playerRotation = Vector3(0.0,_rotation.y,0.0)
	var cameraRotation = Vector3(_rotation.x,0.0,0.0)
	
	transform.basis = Basis.from_euler(cameraRotation)
	player.update_rotation(playerRotation)
	
	rotation.z = 0.0 
	
func updateCameraHeight(delta:) -> void:
	position.y = clampf(position.y,0, 0)
