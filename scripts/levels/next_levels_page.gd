extends TextureButton

func _pressed():
	GameEvents.emit_signal("next_level_page_clicked")
