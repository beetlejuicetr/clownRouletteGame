extends Node3D
#enum ACTIONS {PING, DATA, RETURN, EMOTE, FIRE, SPECIAL}

@onready var resetPos = $revolverResetPos
@onready var myObject = $RevolverArea
@onready var enemyPos = $enemyLook
@onready var mesh = $RevolverArea/REVOLVER
var magazineSize = 8
var magazineArray = []

var isHovered = false
var isHandled = false
func _ready():
	_reset_gun_pos()
	pass # Replace with function body.


	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		var x = Global._is_lobby_owner_me()
		print("lobby owner is you?:",x,Global.CURRENT_LOBBY_ID,Global.STEAM_ID)
		if x:
			_create_new_magazine()
		pass
	pass

func _reset_gun_pos():
	myObject.global_transform = resetPos.global_transform
	pass

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
	if isHandled == false:
		var tween = get_tree().create_tween()
		tween.tween_property(myObject,"position",resetPos.position + Vector3(0,.1,0),.1)
		isHovered = true
	pass # Replace with function body.


func _on_revolver_area_mouse_exited():
	if isHandled == false:
		var tween =  get_tree().create_tween()
		tween.tween_property(myObject,"position",resetPos.position,.1)
		isHovered = false
	pass # Replace with function body.


func _on_revolver_area_input_event(camera, event, position, normal, shape_idx):
	if Input.is_action_just_pressed("action") and isHovered and isHandled == false:
		isHandled = true
		var tween = get_tree().create_tween()
		tween.tween_property(myObject,"global_position",Wiring.playerHand.global_position,.5)
		mesh.look_at_from_position(mesh.global_position,enemyPos.global_position,Vector3.UP,true)
		pass
	pass # Replace with function body.
