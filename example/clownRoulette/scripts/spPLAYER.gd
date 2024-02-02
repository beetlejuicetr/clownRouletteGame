extends Node3D

@onready var cam = $Camera3D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("action"):
		_create_ray()
		pass
	pass

func _create_ray():
	var mousePos = get_viewport().get_mouse_position()
	
	var from = cam.project_ray_origin(mousePos)
	var lenght = 1000
	var to = from + cam.project_ray_normal(mousePos) * lenght
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	var raycastResult = space.intersect_ray(ray_query)
	if !raycastResult.is_empty():
		print(raycastResult)
	pass