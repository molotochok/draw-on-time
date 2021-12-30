extends Button

func _pressed():
	GameEvents.emit_signal("scene_changed")
