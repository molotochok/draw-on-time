extends Button

class_name LevelButton

export(NodePath) onready var background = get_node(background) as TextureRect
export(Resource) onready var background_texture_opened = background_texture_opened as Texture;
export(Resource) onready var background_texture_blocked = background_texture_blocked as Texture;

export(NodePath) onready var index_label = get_node(index_label) as Label
export(NodePath) onready var preview = get_node(preview) as TextureRect
export(NodePath) onready var stars_container = get_node(stars_container) as HBoxContainer

export var button_up_color = Color(1, 1, 1, 1)
export var button_down_color = Color(0.85, 0.85, 0.85, 1)

var _settings: Settings

func _ready():
	assert(connect("button_up", self, "_on_button_up") == OK)
	assert(connect("button_down", self, "_on_button_down") == OK)

func opened():
	return _settings && _settings.opened

func update_settings(settings: Settings, index: int):
	_settings = settings
	index_label.text = str(index)

	if opened():
		background.set_texture(background_texture_opened)
		preview.set_texture(settings.get_ref_preview_texture())
		set_default_cursor_shape(CURSOR_POINTING_HAND)
	else:
		background.set_texture(background_texture_blocked)
		preview.set_texture(null)
		set_default_cursor_shape(CURSOR_ARROW)

	update_stars(settings.get_stars())
	
func update_stars(number: int):
	var stars = stars_container.get_children()

	stars[0].modulate.a = 1 if number > 0 else 0
	stars[1].modulate.a = 1 if number > 1 else 0
	stars[2].modulate.a = 1 if number > 2 else 0

func make_visible(show: bool):
	if show:
		modulate.a = 1
	else:
		modulate.a = 0
		set_default_cursor_shape(CURSOR_ARROW)

func _pressed():
	if(opened()):
		LevelManager.load_main_level(_settings.index)
	
func _on_button_up():
	if(opened()):
		modulate = button_up_color
	
func _on_button_down():
	if(opened()):
		modulate = button_down_color
	
