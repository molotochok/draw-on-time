extends DrawingCanvas

func init_handlers():
	.init_handlers()
	
	assert(GameEvents.connect("scene_created", self, "_on_scene_created") == OK)

func _on_settings_initialized(settings: Settings):
	_settings = settings
	update_pen_size()

func _on_scene_created():
	var index = LevelManager.level_count + 1
	var img = main_texture_rect.get_texture().get_data()

	save_img(img, index)
	save_preview(img, index)
	save_settings(index)

func save_img(img: Image, index: int):
	assert(img.save_png(Paths.SPRITE_REFERENCES % str(index)) == OK)

func save_preview(img: Image, index: int):
	var resize_factor := 6
	img.resize(img.get_width() / resize_factor, img.get_height() / resize_factor)
	assert(img.save_png(Paths.SPRITE_PREVIEW_REFERENCES % str(index)) == OK)

func save_settings(index: int):
	var settings = _settings.duplicate()
	settings.index = index

	if(index <= 1):
		settings.get_stats().opened = true

	GameEvents.emit_signal("settings_save_requested", settings)  
