extends Node
#################################################
# GODOT SINGLEPLAYER VARIABLES
#################################################
var SPgunTurn = false
var SPcardTurn = true
var SPgunHandled = false
enum  SP_GROUPS {ENEMY,REVOLVER,PLAYER,CARDDECK}
################ 0 , 1 , 2 , 3 
enum CARD_TYPES {SPIN, LOOK, X2SHOOT, SHOOTSELF, ROUNDPASS, STEALCARD, AGAIN}







#################################################
# GODOT STEAM VARIABLES
#################################################
var IS_ON_STEAM: bool = false
var IS_ON_STEAM_DECK: bool = false
var IS_ONLINE: bool = false
var IS_OWNED: bool = false
var STEAM_ID: int = 0
var STEAM_USERNAME: String = "No one"
var APP_ID: String = "480" # setup 480 for testing.
var CURRENT_LOBBY_ID : int = 0


enum ACTIONS {PING, DATA, RETURN, EMOTE, FIRE, SPECIAL, TURN}
enum TYPES {GUN, CHARACTER, TABLE, SCENE}
func _ready() -> void:
	OS.set_environment("SteamAppId", APP_ID)
	OS.set_environment("SteamGameId", APP_ID)
	print("Starting the GodotSteam Example project...")
	_initialize_Steam()

	if IS_ON_STEAM_DECK:
		get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN


func _initialize_Steam() -> void:
	if Engine.has_singleton("Steam"):
		var INIT: Dictionary = Steam.steamInit(false)
		# If the status isn't one, print out the possible error and quit the program
		if INIT['status'] != 1:
			print("[STEAM] Failed to initialize: "+str(INIT['verbal'])+" Shutting down...")
			get_tree().quit()

		# Is the user actually using Steam; if false, the app assumes this is a non-Steam version
		IS_ON_STEAM = true
		# Checking if the app is on Steam Deck to modify certain behaviors
		IS_ON_STEAM_DECK = Steam.isSteamRunningOnSteamDeck()
		# Acquire information about the user
		IS_ONLINE = Steam.loggedOn()
		IS_OWNED = Steam.isSubscribed()
		STEAM_ID = Steam.getSteamID()
		STEAM_USERNAME = Steam.getPersonaName()

		# Check if account owns the game
		if IS_OWNED == false:
			print("[STEAM] User does not own this game")
			# Uncomment this line to close the game if the user does not own the game
			#get_tree().quit()


# Process all Steamworks callbacks
func _process(_delta: float) -> void:
	if IS_ON_STEAM:
		Steam.run_callbacks()


func _is_lobby_owner_me():
	if Global.STEAM_ID == Steam.getLobbyOwner(CURRENT_LOBBY_ID):
		return true
	else:
		return false
	pass
