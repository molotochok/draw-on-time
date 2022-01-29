extends TextureButton

func _init():
	assert(GameEvents.connect("settings_initialized", self, "_on_settings_initialized") == OK)
	assert(GameEvents.connect("settings_updated", self, "_on_settings_updated") == OK)

func _pressed():
  LevelManager.load_next_level()

func _on_settings_initialized(settings: Settings):
	change_visibility(settings)

func _on_settings_updated(settings: Settings):
	change_visibility(settings)

func change_visibility(settings: Settings):
	set_visible(settings.passed())
