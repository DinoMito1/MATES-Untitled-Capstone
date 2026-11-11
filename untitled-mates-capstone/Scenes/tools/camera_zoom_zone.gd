extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.get_parent().get_child(0) is Camera2D:
		get_tree().create_tween().tween_property($"../Player/Camera2D", "zoom", Vector2(0.78,0.78) * self.get_meta("cameraZoom"), self.get_meta('zoomAnimTime')).set_trans(Tween.TRANS_EXPO)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D and body.get_parent().get_child(0) is Camera2D:
		get_tree().create_tween().tween_property($"../Player/Camera2D", "zoom", Vector2(0.78,0.78), self.get_meta('zoomAnimTime')).set_trans(Tween.TRANS_EXPO)
