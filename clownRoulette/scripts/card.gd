extends MeshInstance3D

var isHovered = false
var canTouched = false

var resetPos
# Called when the node enters the scene tree for the first time.
func _ready():
	resetPos = self.position
	$Timer.start()
	pass # Replace with function body.



func _on_card_area_mouse_entered():
	if canTouched:
		isHovered = true
		var tween = get_tree().create_tween()
		tween.tween_property(self,"position",resetPos + Vector3(0,0.1,0),.1)
	pass # Replace with function body.


func _on_card_area_mouse_exited():
	if canTouched:
		isHovered = false
		var tween = get_tree().create_tween()
		tween.tween_property(self,"position",resetPos,.1)
	pass # Replace with function body.


func _on_timer_timeout():
	canTouched = true
	$Timer.stop()
	pass # Replace with function body.
