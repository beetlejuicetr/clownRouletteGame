extends CharacterBody3D
#enum ACTIONS {PING, DATA, RETURN, EMOTE, FIRE, SPECIAL}

@onready var resetPos = $revolverResetPos
@onready var myObject = $RevolverArea
@onready var enemyPos = $enemyLook
@onready var mesh = $RevolverArea/REVOLVER

var magazineSize = 8
var magazineArray = []

var isHovered = false
var isHandled = false
var resetMesh = Vector3()
var firstmesh = true
func _ready():
	self.add_to_group(str(Global.SP_GROUPS.REVOLVER))
	
	_reset_gun_pos()
	
	pass # Replace with function body.

func _input(event):
	_create_ray()
	if Global.SPgunHandled == false and Global.SPgunTurn == false:
		await  get_tree().create_timer(.2).timeout
		_reset_gun_pos()
		_reset_mesh_pos()
		
	pass
	
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		var x = Global._is_lobby_owner_me()
		print("lobby owner is you?:",x,Global.CURRENT_LOBBY_ID,Global.STEAM_ID)
		if x:
			_create_new_magazine()
		pass
	pass

func _reset_gun_pos():
	var tween = get_tree().create_tween()
	tween.tween_property(myObject,"global_transform",resetPos.global_transform,0.1)
	#myObject.global_transform = resetPos.global_transform
	if firstmesh:
		firstmesh = false
		resetMesh = mesh.global_transform
	_reset_mesh_pos()

func _reset_mesh_pos():
	var tween = get_tree().create_tween()
	tween.tween_property(mesh,"global_transform",resetMesh,0.1)
	#mesh.global_transform = resetMesh

func _create_new_magazine():
	magazineArray.clear()
	
	var RNG = RandomNumberGenerator.new()
	var number = RNG.randi_range(0,magazineSize - 1)
	for i in magazineSize:
		if i == number:
			magazineArray.append(true)
		else:
			magazineArray.append(false)
		pass
	print(magazineArray,magazineArray.find(true,0),"//",number)
	
	var MAGAZINE_DATA: Dictionary = {"action":Global.ACTIONS.DATA, "type":Global.TYPES.GUN, "player_id":Global.STEAM_ID, "size":magazineSize, "magazine":magazineArray}
	Wiring.P2P._send_P2P_Packet(0, MAGAZINE_DATA)
	pass


func _on_revolver_area_mouse_entered():
	print("girdi cikti")
	if Global.SPgunHandled == false and Global.SPgunTurn:
		var tween = get_tree().create_tween()
		tween.tween_property(myObject,"position",resetPos.position + Vector3(0,.1,0),.1)
		isHovered = true
	pass # Replace with function body.


func _on_revolver_area_mouse_exited():
	if Global.SPgunHandled == false and Global.SPgunTurn:
		var tween =  get_tree().create_tween()
		tween.tween_property(myObject,"position",resetPos.position,.1)
		isHovered = false
	pass # Replace with function body.

func _create_ray():
	var mousePos = get_viewport().get_mouse_position()
	
	var from = Wiring.XenonCamera3D.project_ray_origin(mousePos)
	var lenght = 10000
	var to = from +  Wiring.XenonCamera3D.project_ray_normal(mousePos) * lenght
	var space = get_parent().get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	var raycastResult = space.intersect_ray(ray_query)
	if !raycastResult.is_empty() and Global.SPgunHandled:
		if raycastResult["collider"].get_groups()[0] == str(Global.SP_GROUPS.ENEMY): 
			mesh.look_at_from_position(mesh.global_position,raycastResult["position"],Vector3.UP,true)
	

func _on_revolver_area_input_event(camera, event, position, normal, shape_idx):
	
	pass # Replace with function body.
func _give_revolver(pos):
	var tween = get_tree().create_tween()
	tween.tween_property(myObject,"global_position",pos,0.1)
	await  get_tree().create_timer(.1).timeout
	mesh.look_at_from_position(mesh.global_position,enemyPos.global_position,Vector3.UP,true)
	
