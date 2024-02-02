extends Camera3D

var myPlayer = null
func _ready() -> void:
	pass

func _physics_process(delta) -> void:
	look_at_from_position(self.global_transform.origin,Wiring.CamReset.global_transform.origin,Vector3.UP)
	if myPlayer != null:
		var tween = get_tree().create_tween()
		tween.tween_property(self,"position",Vector3(myPlayer.position),1)
		pass
	pass
