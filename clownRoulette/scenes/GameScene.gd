extends Node3D


@onready var player = preload("res://clownRoulette/scenes/player.tscn")
var posi = []
var chairPositions = []
var playerModels = []
@export var chairIndex = [0,0,0,0]
@onready var playersIn3d : Node3D = $PLAYERS
@onready var gameWorld3d : Node3D = self
@onready var playerPositions : Node3D = $PLAYERPOS

@onready var characterReset : Marker3D = $CharacterReset
func _ready() -> void:
	var arra = [0,1,2,3]
	for i in arra:
		print(arra[arra.find(i,0)])
	
	var x = Wiring.P2P.LOBBY_MEMBERS
	print("MEMBERS",x)
	for chair in playerPositions.get_children():
		chairPositions.append(chair)
	print("chairs",chairPositions)
	pass

func _physics_process(delta):
	pass



func _create_3d_player_models(steam_id: int ,steam_name: String) -> void:
	
	if chairIndex.find(steam_id) == -1 and chairIndex.find(0) >= 0:
		print("Creating sequence: ",steam_id,steam_name,"pos:",chairIndex.find(0))
		
		var playerIns = player.instantiate()
		
		
		for i2 in len(chairIndex):
			if chairIndex[i2] == 0 and chairIndex.find(0,0) > -1:
				chairIndex.remove_at(i2)
				chairIndex.insert(chairIndex.find(0),steam_id)
				
				print("[TEST]: ",chairIndex)
				break
			
			else:
				pass
		playersIn3d.add_child(playerIns)
		print("whic chair mine",chairPositions[chairIndex.find(steam_id,0)],chairIndex.find(steam_id,0),chairIndex,steam_id)
		playerIns.global_position = chairPositions[chairIndex.find(steam_id,0)].global_position + Vector3(0,1,0)
		playerIns.name = str(steam_id)
		if playerIns.name == str(Global.STEAM_ID):
			Wiring.PlayerCamera.myPlayer = playerIns
			playerIns.visible = false
		
		playerIns.get_node("Label3D").text = steam_name
		playerIns.lookPos = characterReset
	elif chairIndex.find(0) == -1:
		print("Abort sequence: ",steam_id,steam_name,"pos:",chairIndex.find(0))
		
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
						chairIndex.append(0)
						chairIndex.erase(z["steam_id"])
						break
				pass
			pass
	
	pass

func _clear_all_players():

	Wiring.PlayerCamera.myPlayer = null
	for i in playersIn3d.get_children():
		if chairIndex.find(str(i.name),0):
			chairIndex.append(0)
			chairIndex.erase(str(i.name))
		i.queue_free()
	pass


func _on_ping_pong_timeout():
	pass # Replace with function body.


func _on_start_pressed():
	Wiring.P2P.visible = false
	pass # Replace with function body.
