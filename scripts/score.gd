extends Control

export(NodePath) onready var stars_container = get_node(stars_container)
export(Resource) onready var star_texture;

func _ready():
	assert(GameEvents.connect("settings_initialized", self, "_on_settings_initialized") == OK)
	assert(GameEvents.connect("settings_updated", self, "_on_settings_updated") == OK)
	
func _on_settings_initialized(settings: Settings):
	show_stars(settings.get_stars())

func _on_settings_updated(settings: Settings):
	show_stars(settings.get_stars())

func show_stars(number: int):
	var stars = stars_container.get_children()
	
	number > 0 && stars[0].set_texture(star_texture)
	number > 1 && stars[1].set_texture(star_texture)
	number > 2 && stars[2].set_texture(star_texture)

