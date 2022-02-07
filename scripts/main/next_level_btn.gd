extends InteractableTextureButton

export(NodePath) onready var anim_player = get_node(anim_player) as AnimationPlayer

func _init():
	assert(GameEvents.connect("settings_initialized", self, "_on_settings_initialized") == OK)
	assert(GameEvents.connect("settings_updated", self, "_on_settings_updated") == OK)

func _pressed():
	LevelManager.load_next_level()

func _on_settings_initialized(settings: Settings):
	toggle_disable_by(settings, false)

func _on_settings_updated(settings: Settings):
	toggle_disable_by(settings, true)

func toggle_disable_by(settings: Settings, should_animate: bool):
	if should_disable(settings):
		toggle_disable(true)
		return

	if should_animate:
		anim_player.play("next_level_btn")
	else:
		toggle_disable(false)

func should_disable(settings: Settings):
	return settings.index >= LevelManager.level_count || !settings.passed()
