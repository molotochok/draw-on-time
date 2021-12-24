extends Button

func _pressed():
	GameEvents.emit_signal("refreshed")
