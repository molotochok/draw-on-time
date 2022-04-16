extends Control

export(Resource) onready var star_texture;

func _ready():
	GameEvents.connect("settings_initialized", self, "_on_settings_initialized")
	GameEvents.connect("score_calculated", self, "_on_score_calculated")
	
func _on_settings_initialized(settings: Settings):
	show_stars(settings.get_stats().get_stars(), false)

func _on_score_calculated(score: float):
	show_stars(Stats.get_stars_by(score), true)

func show_stars(number: int, should_animate: bool):
	var stars = get_children()
	
	number > 0 && stars[0].show_star(should_animate)
	number > 1 && stars[1].show_star(should_animate)
	number > 2 && stars[2].show_star(should_animate)

