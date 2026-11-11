extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.get_parent().get_child(0) is Camera2D:
		Global.camLocked=true
		Global.cameraMouseInfluence = self.get_meta("mouseInfluence")
		#$"../Player/Camera2D".position.x = (self.position.x-500) + self.get_meta("CameraLockPos").x
		#$"../Player/Camera2D".position.y = (self.position.y-500) + self.get_meta("CameraLockPos").y
		Global.lockedCameraPos = (self.position - Vector2(500,500)) + Vector2(self.get_meta("CameraLockPos"))

func _on_area_2d_body_exited(body: Node2D) -> void:
		if body is CharacterBody2D and body.get_parent().get_child(0) is Camera2D:
			Global.camLocked=false
			Global.cameraMouseInfluence = .55
