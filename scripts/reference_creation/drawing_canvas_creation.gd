extends DrawingCanvas

var start_drawing_time_ms: int
var total_drawing_time_ms: int

func init_handlers():
	.init_handlers()
	
	GameEvents.connect("scene_created", self, "_on_scene_created")

func _physics_process(delta):
	._physics_process(delta)

	if is_mouse_in_viewport(get_local_mouse_position()):
		if Input.is_action_just_pressed("click"):
			start_drawing_time_ms = OS.get_ticks_msec()

		if Input.is_action_just_released("click"):
			total_drawing_time_ms += OS.get_ticks_msec() - start_drawing_time_ms

func _on_settings_initialized(settings: Settings):
	_settings = settings
	update_pen_size()

func _on_scene_created():
	var index = LevelManager.level_count + 1
	var img = main_texture_rect.get_texture().get_data()

	save_img(img, index)
	save_preview(img, index)
	save_settings(index)

func _on_refreshed():
	._on_refreshed()

	total_drawing_time_ms = 0

func save_img(img: Image, index: int):
	img.save_png(Paths.SPRITE_REFERENCES % str(index))

func save_preview(img: Image, index: int):
	var resize_factor := 6
	img.resize(img.get_width() / resize_factor, img.get_height() / resize_factor)
	img.save_png(Paths.SPRITE_PREVIEW_REFERENCES % str(index))

func save_settings(index: int):
	var settings = _settings.duplicate()
	settings.index = index
	settings.time = total_drawing_time_ms / 1000.0 + 0.5

	if(index <= 1):
		settings.get_stats().opened = true

	GameEvents.emit_signal("settings_save_requested", settings)  
