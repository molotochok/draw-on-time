extends InteractableTextureButton

export(NodePath) onready var anim_player = get_node(anim_player) as AnimationPlayer

func _init():
	GameEvents.connect("settings_initialized", self, "_on_settings_initialized")
	GameEvents.connect("stats_updated", self, "_on_stats_updated")

func _pressed():
	LevelManager.load_next_level()

func _on_settings_initialized(settings: Settings):
	toggle_disable_by(settings.get_stats(), false)

func _on_stats_updated(stats: Stats):
	toggle_disable_by(stats, true)

func toggle_disable_by(stats: Stats, should_animate: bool):
	if should_disable(stats):
		toggle_disable(true)
		return

	if should_animate:
		anim_player.play("next_level_btn")
	else:
		toggle_disable(false)

func should_disable(stats: Stats):
	return stats.index >= LevelManager.level_count || !stats.passed()
