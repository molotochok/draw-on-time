extends Button

export(NodePath) onready var index_label = get_node(index_label) as Label
export(NodePath) onready var preview = get_node(preview) as TextureRect
export(NodePath) onready var stars_container = get_node(stars_container) as HBoxContainer

export var button_up_color = Color(1, 1, 1, 1)
export var button_down_color = Color(0.85, 0.85, 0.85, 1)

var _index: int

func _ready():
	connect("button_up", self, "_on_button_up")	
	connect("button_down", self, "_on_button_down")

func update_settings(settings: Settings, index: int):
	_index = index
	index_label.text = str(index)
	preview.set_texture(settings.get_ref_preview_texture())
	update_stars(settings.get_stars())
	
# Todo: get rid of code duplication with score script
func update_stars(number: int):
	var stars = stars_container.get_children()
	if(number > 0):
		stars[0].set_modulate(Color.white)
		
	if(number > 1):
		stars[1].set_modulate(Color.white)
	
	if(number > 2):
		stars[2].set_modulate(Color.white)

func _pressed():
	LevelManager.load_main_level(_index)
	
func _on_button_up():
	modulate = button_up_color
	
func _on_button_down():
	modulate = button_down_color
	
