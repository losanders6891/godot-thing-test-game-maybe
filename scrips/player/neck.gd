## controlls camera rotation
class_name neck extends Node3D
@export var _rotation: Vector3
@export_category("references")
@export var playerCont : playerController
@export var mouseDetect : mouseCapture

##rotates the camera
func updateCameraRotation(input: Vector2) -> void: 
	_rotation.y = input.y
	_rotation.x = input.x
	
	var playerRotation = Vector3(0.0,_rotation.x,0.0)
	var cameraRotation = Vector3(_rotation.y,0.0,0.0)
	
	transform.basis = Basis.from_euler(cameraRotation)
	playerCont.update_rotation(playerRotation)
	
	_rotation.z = 0.0 
	
func updateCameraHeight(_delta:) -> void:
	position.y = clampf(position.y,0, 0)

func _process(_delta: float) -> void:
	updateCameraRotation(mouseDetect.mouseInput)
