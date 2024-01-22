extends Node3D


@onready var player = preload("res://clownRoulette/scenes/player.tscn")
var posi = []
var chairPositions = []
var playerModels = []
@export var chairIndex = [0,0,0,0]
@onready var playersIn3d : Node3D = $PLAYERS
@onready var gameWorld3d : Node3D = self
@onready var playerPositions : Node3D = $PLAYERPOS
func _ready() -> void:
	var x = Wiring.P2P.LOBBY_MEMBERS
	print("MEMBERS",x)
	for chair in playerPositions.get_children():
		chairPositions.append(chair)
	pass

func _physics_process(delta):
	pass



func _create_3d_player_models(playersInfo):
	print(playersInfo)
	for i in playersInfo:
		var playerIns = player.instantiate()
		
		playersIn3d.add_child(playerIns)
		for i2 in len(chairIndex):
			if chairIndex[i2] == 0:
				chairIndex.insert(i2,i["steam_id"])
				break
		playerIns.global_position = chairPositions[chairIndex.find(i["steam_id"])].global_position
		playerIns.name = str(i["steam_id"])
		playerIns.get_node("Label3D").text = i["steam_name"]
		
		pass
	pass

func _clear_3d_player_models(playersInfo):
	print("3D MODELS CLEANING")
	for z in playersInfo:
		for i in playersIn3d.get_children():
			print(i)
			if i.name == str(z["steam_id"]):
				i.queue_free()
				for i2 in len(chairIndex):
					if chairIndex[i2] == z["steam_id"]:
						chairIndex.insert(i2,0)
						break
				pass
			pass
	
	pass
