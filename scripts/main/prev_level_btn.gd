extends InteractableTextureButton

func _init():
	GameEvents.connect("settings_initialized", self, "_on_settings_initialized")
	GameEvents.connect("stats_updated", self, "_on_stats_updated")

func _pressed():
  LevelManager.load_prev_level()

func _on_settings_initialized(settings: Settings):
	toggle_disable_by(settings.get_stats())

func _on_stats_updated(stats: Stats):
	toggle_disable_by(stats)

func toggle_disable_by(stats: Stats):
  toggle_disable(stats.index <= 1)
    