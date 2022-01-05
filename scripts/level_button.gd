extends Control

export(NodePath) onready var index_label = get_node(index_label) as Label
export(NodePath) onready var preview = get_node(preview) as TextureRect
export(NodePath) onready var stars_container = get_node(stars_container) as HBoxContainer

func _ready():
	var settings = load(Paths.MAIN_SETTING % 4)

# TODO: Not quite a good name since I am not updating settings
func update_settings(settings: Settings, index: int):
	index_label.text = str(index)
	preview.set_texture(settings.ref_texture)
	update_stars(settings.get_stars())
	
# Todo: get rid of code duplication with score script
func update_stars(number: int):
	var stars = stars_container.get_children()
	if(number > 0):
		stars[0].set_modulate(Color.white)
		
	if(number > 1):
		stars[1].set_visible(Color.white)
	
	if(number > 2):
		stars[2].set_visible(Color.white)
