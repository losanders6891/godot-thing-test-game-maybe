class_name mouseCapture extends Node
@export_category("mouse capture settings")
@export var mouseSensitivity = 0.005


var captureMouse : bool
var mouseInput : Vector2

# runs if an input is detected doesnt get used by Input
func _unhandled_input(event: InputEvent) -> void:
	#recaptures mouse if it clicks on the window.
	if event is InputEventMouseButton and Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	#checks if the registered movement is mouse motion
	captureMouse = event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED
	if captureMouse:
		mouseInput.x += -event.screen_relative.x * mouseSensitivity
		mouseInput.y += -event.screen_relative.y * mouseSensitivity
#initialy sets mouse mode
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
#prevents mouse input from accumulating
