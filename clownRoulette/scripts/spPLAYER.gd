extends Node
@onready var hand = $playerHand
@onready var cam = $XenonCamera3D
@onready var bulletHole = preload("res://clownRoulette/scenes/bullet_hole.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _physics_process(delta):
	_create_ray()



func _create_ray():
	var mousePos = get_viewport().get_mouse_position()
	
	var from = cam.project_ray_origin(mousePos)
	var lenght = 10000
	var to = from + cam.project_ray_normal(mousePos) * lenght
	var space = get_parent().get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	var raycastResult = space.intersect_ray(ray_query)
	

	if !raycastResult.is_empty() and Input.is_action_just_pressed("action"):
		print("result:", raycastResult)
		var x = raycastResult["collider"]
		
		print(x.get_groups())
		
		_search_action(x,x.get_groups(),raycastResult["position"])
	pass

func _search_action(to,group,pos):
	for i in group:
		print(i,group,Global.SP_GROUPS)
		if i == str(Global.SP_GROUPS.ENEMY):
			_shoot(to,pos)
		elif i == str(Global.SP_GROUPS.CARDDECK):
			_get_card(to)
		elif i == str(Global.SP_GROUPS.REVOLVER):
			_take_revolver(to,pos)
			pass
	pass

func _shoot(to,pos):
	if Global.SPgunTurn and Global.SPgunHandled:
		## to.deathAnim()
		var bulletHoleIns = bulletHole.instantiate()
		## find mesh for create
		bulletHoleIns.position = Vector3(pos)
		get_parent().add_child(bulletHoleIns)
		Global.SPgunHandled = false
		Global.SPgunTurn = false
		
		pass
	pass

func _get_card(to):
	if Global.SPcardTurn:
		to._get_a_card("player")
	pass

func _take_revolver(to,pos):
	if Global.SPgunTurn and Global.SPgunHandled == false:
		print("i am ready for that gun")
		Global.SPgunHandled = true
		to._give_revolver(hand.global_position)
		pass
	
	
	pass
