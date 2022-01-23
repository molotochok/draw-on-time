extends TextureButton

func _pressed():
	GameEvents.emit_signal("prev_level_page_clicked")
