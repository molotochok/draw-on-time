extends TextureButton

func _pressed():
	GameEvents.emit_signal("refreshed")
