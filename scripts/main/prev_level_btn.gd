extends TextureButton

func _init():
	assert(GameEvents.connect("settings_initialized", self, "_on_settings_initialized") == OK)
	assert(GameEvents.connect("settings_updated", self, "_on_settings_updated") == OK)

func _pressed():
  LevelManager.load_prev_level()

func _on_settings_initialized(settings: Settings):
	toggle_disable(settings)

func _on_settings_updated(settings: Settings):
	toggle_disable(settings)

func toggle_disable(settings: Settings):
  if settings.index != 1:
    disabled = false
    set_default_cursor_shape(CURSOR_POINTING_HAND)
  else:
    disabled = true
    set_default_cursor_shape(CURSOR_ARROW)
    