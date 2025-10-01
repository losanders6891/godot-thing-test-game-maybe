extends CharacterBody3D
var movespeed = 7
var gravity = 15
var jumpspeed = 20 
var dashspeed = 30


#exports data or somthing, refrence in later code on other 
@export_category("mouse capture settings")
@export var mouseSensitivity = 0.005


var captureMouse : bool
var mouseInput : Vector2

# runs if an input is detected doesnt get used by Input
func _unhandled_input(event: InputEvent) -> void:
	#recaptures mouse if it clicks on the window.
	if event is InputEventMouseButton and Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	#checks if the registered movement is mouse motion
	captureMouse = event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED
	if captureMouse:
		mouseInput.x += -event.screen_relative.x * mouseSensitivity
		mouseInput.y += -event.screen_relative.y * mouseSensitivity
	print_debug(mouseInput)
#initialy sets mouse mode
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
#prevents mouse input from accumulating
func _process(delta: float) -> void:
	mouseInput = Vector2.ZERO
#start the main physics loop
func _physics_process(delta):
	#initialize and reset direction
	var relative_direction = Vector3.ZERO
	if Input.is_action_pressed("noLock"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	#XZ = ground plane
	if Input.is_action_pressed("walk-forward"):
		relative_direction.z -= 1
	if Input.is_action_pressed("walk-backward"):
		relative_direction.z += 1
	if Input.is_action_pressed("strafe-left"):
		relative_direction.x -= 1
	if Input.is_action_pressed("strafe-right"):
		relative_direction.x += 1
	
	if Input.is_action_pressed("jump") and  is_on_floor():
		velocity.y += jumpspeed
	if not is_on_floor():
		velocity.y -= gravity
	#normalize movement
	if relative_direction != Vector3.ZERO:
		relative_direction = relative_direction.normalized() 
	
	
	
	
		
		

		
	
	
	
	
	
