extends Camera3D
var speed = 0.001
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	pass
func _process(delta):
	if Input.is_action_just_pressed("action"):
		$CanvasLayer/cursor.texture = preload("res://clownRoulette/assets/cursors/cursorclick.png")
	elif  Input.is_action_just_released("action"):
		$CanvasLayer/cursor.texture = preload("res://clownRoulette/assets/cursors/cursor.png")
	$CanvasLayer/cursor.position = get_viewport().get_mouse_position()
	
	rotation.x = clamp(rotation.x,-.4,.06)
	rotation.y = clamp(rotation.y,-.25,.25)
	pass

func _input(event):
	if event is InputEventMouseMotion:
		rotate(Vector3.UP, -event.relative.x * speed)
		rotate_object_local(Vector3.RIGHT,-event.relative.y * speed)
	pass
