extends CharacterBody3D

var lookPos = null
@onready var animP = $clown/ClownAnimPlayer
func _ready() -> void:
	animP.play("Idle1")
	pass
func _physics_process(delta):
	if lookPos != null:
		look_at_from_position(self.global_transform.origin,lookPos.global_transform.origin,Vector3.UP)
	if Input.is_action_just_pressed("ui_page_down"):
		animP.play("Idle2")
		pass
	pass
