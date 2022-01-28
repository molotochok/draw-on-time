extends Control

export(NodePath) onready var stars_container = get_node(stars_container)

func _ready():
	GameEvents.connect("settings_initialized", self, "_on_settings_initialized")
	GameEvents.connect("settings_updated", self, "_on_settings_updated")
	
func _on_settings_initialized(settings: Settings):
	show_stars(settings.get_stars())

func _on_settings_updated(settings: Settings):
	show_stars(settings.get_stars())

func show_stars(number: int):
	var stars = stars_container.get_children()
	
	stars[0].set_visible(number > 0)
	stars[1].set_visible(number > 1)
	stars[2].set_visible(number > 2)

