extends CharacterBody3D

var lookPos = null

func _ready() -> void:
	
	pass
func _physics_process(delta):
	if lookPos != null:
		look_at_from_position(self.global_transform.origin,lookPos.global_transform.origin,Vector3.UP)
	pass
