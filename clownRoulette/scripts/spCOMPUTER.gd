extends Node3D

var trigger = false
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


func _physics_process(delta):
	if Global.SPcardTurn == false and Global.SPgunTurn == false and trigger == false:
		trigger = true
		$Timer.start()
	pass


func _on_timer_timeout():
	trigger = false
	Wiring.cardDeck._get_a_card("computer")
	print("COMPUTER TETIKLENDI")
	$Timer.stop()
	pass # Replace with function body.
