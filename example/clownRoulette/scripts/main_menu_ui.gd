extends Control

@onready var isOnline = $isOnline
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if Global.IS_ONLINE:
		isOnline.color = Color.GREEN
		
	else:
		isOnline.color = Color.RED
	pass







func _on_settings_pressed():
	pass # Replace with function body.


func _on_exit_pressed():
	pass # Replace with function body.


func _on_play_online_pressed(extra_arg_0):
	Loading._load_Scene(extra_arg_0)
	pass # Replace with function body.


func _on_play_offline_pressed(extra_arg_0):
	Loading._load_Scene(extra_arg_0)
	pass # Replace with function body.
