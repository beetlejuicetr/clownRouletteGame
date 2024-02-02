extends Camera3D
var speed = 0.001
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass
func _process(delta):
	rotation.x = clamp(rotation.x,-.5,.5)
	rotation.y = clamp(rotation.y,-1,1)
	pass

func _input(event):
	if event is InputEventMouseMotion:
		rotate(Vector3.UP, -event.relative.x * speed)
		rotate_object_local(Vector3.RIGHT,event.relative.y * speed)
	pass
