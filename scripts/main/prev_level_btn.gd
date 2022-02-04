extends InteractableTextureButton

func _init():
	assert(GameEvents.connect("settings_initialized", self, "_on_settings_initialized") == OK)
	assert(GameEvents.connect("settings_updated", self, "_on_settings_updated") == OK)

func _pressed():
  LevelManager.load_prev_level()

func _on_settings_initialized(settings: Settings):
	toggle_disable_by(settings)

func _on_settings_updated(settings: Settings):
	toggle_disable_by(settings)

func toggle_disable_by(settings: Settings):
  toggle_disable(settings.index <= 1)
    