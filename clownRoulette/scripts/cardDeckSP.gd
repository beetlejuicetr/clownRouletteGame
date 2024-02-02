extends Node3D

enum CARDS {LOOK_GUN,SPIN_GUN,X2SHOOT,ROUND_PASS,STEAL_CARD,PROTECTION}



var isHovered = false
@onready var cardScene = preload("res://clownRoulette/scenes/card.tscn")
@onready var playerDesk = Wiring.cardPlaceHolderPlayer
@onready var computerDesk = Wiring.cardPlaceHolderComputer
var index = {"player":[],"computer":[]}
var comIndex = []
var posChilds = []
var comChilds = []

func _prepare_card():
	var rng = RandomNumberGenerator.new()
	var x = Global.CARD_TYPES.get(1)
	print(x)
	pass

func _physics_process(delta):
	pass
func _ready():
	_prepare_card()
	for i in playerDesk.get_children():
		posChilds.append(i)
		index["player"].append(true)
		pass
	for i2 in computerDesk.get_children():
		comChilds.append(i2)
		index["computer"].append(true)
		pass
	print(index)
func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	if Input.is_action_just_pressed("action") and isHovered and Global.SPcardTurn:
		_get_a_card("player")
		
		pass
	pass # Replace with function body.

func _get_a_card(to):
	print("CARD REQUEST")
	
	var cardIns = cardScene.instantiate()
	
	for i in index[to]:
		if i and to == "player":
			
			posChilds[index[to].find(i,0)].add_child(cardIns)
			Global.SPcardTurn = false
			break
		elif i and to == "computer":
			comChilds[index[to].find(i,0)].add_child(cardIns)
			Global.SPcardTurn = true
			
			break
		else:
			pass
		
	if index[to].find(true,0) != -1:
		
		index[to][index[to].find(true,0)] = false
		
		var firstPos = cardIns.global_transform
		cardIns.global_transform.origin = self.global_transform.origin + Vector3(0,.1,0)
			
		var tw = get_tree().create_tween()
			
		tw.tween_property(cardIns,"global_transform",firstPos,.7)
		tw.tween_property(cardIns,"rotation",Vector3(0,0,0),.5)
	pass

func _on_area_3d_mouse_entered():
	isHovered = true
	pass # Replace with function body.


func _on_area_3d_mouse_exited():
	isHovered = false
	pass # Replace with function body.

