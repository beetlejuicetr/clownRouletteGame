extends Node3D

@onready var cam = $Camera3D
@onready var bulletHole = preload("res://clownRoulette/scenes/bullet_hole.tscn")
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
		print("result:", raycastResult)
		var x = raycastResult["collider"]
		
		print(x.get_groups())
		
		_search_action(x,x.get_groups(),raycastResult["position"])
	pass

func _search_action(to,group,position):
	for i in group:
		print(i,group)
		#if group[i] == Global.SP_GROUPS.ENEMY:
		#	_shoot(to,position)
	pass

func _shoot(to,position):
	if Global.SPgunTurn and Global.SPgunHandled:
		## to.deathAnim()
		var bulletHoleIns = bulletHole.instantiate()
		## find mesh for create
		add_child(bulletHoleIns)
		pass
	pass
