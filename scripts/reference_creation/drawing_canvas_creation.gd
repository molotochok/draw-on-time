extends DrawingCanvas

func init_handlers():
	.init_handlers()
	
	GameEvents.connect("scene_created", self, "_on_scene_created")

func _on_settings_initialized(settings: Settings):
	_settings = settings
	update_pen_size()

func _on_scene_created():
  var index = LevelManager.level_count + 1
  
  var img = main_texture_rect.get_texture().get_data()
  img.save_png(Paths.SPRITE_REFERENCES % str(index))

  var resize_factor := 5
  img.resize(img.get_width() / resize_factor, img.get_height() / resize_factor)
  img.save_png(Paths.SPRITE_PREVIEW_REFERENCES % str(index))
	
  var settings = _settings.duplicate()
  settings.index = index
  ResourceSaver.save(Paths.MAIN_SETTING % index, settings)
  
  LevelManager.increment_level_count()
