extends Button

func _pressed():
	GameEvents.emit_signal("scene_created")
	GameEvents.emit_signal("refreshed")
