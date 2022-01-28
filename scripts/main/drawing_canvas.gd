extends Control

class_name DrawingCanvas

export(NodePath) onready var ref_texture_rect = get_node(ref_texture_rect) as TextureRect
export(NodePath) onready var main_texture_rect = get_node(main_texture_rect) as TextureRect

onready var _pen := Node2D.new()
var _pen_size := 10.0

var _settings: Settings

var _prev_mouse_pos := Vector2()
var _can_draw := true
var _viewport: Viewport

var _score_calculator := ScoreCalculator.new()

##### Main handlers #####
func _ready():
	init_main_texture_viewport()
	init_handlers()

func _process(_delta):
	if(_can_draw):
		_pen.update()

##### Custom handlers #####
func _on_refreshed():
	_viewport.set_clear_mode(Viewport.CLEAR_MODE_ALWAYS)
	_viewport.set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)

	if !_can_draw:
		_can_draw = true

func _on_finished():
	_can_draw = false
	_score_calculator.calculate(main_texture_rect, ref_texture_rect)

func _on_settings_initialized(settings: Settings):
	_settings = settings
	
	ref_texture_rect.set_texture(settings.get_ref_texture())
	main_texture_rect.get_material().set_shader_param("reference", settings.get_ref_texture())
	
	update_pen_size()

func _on_draw():
	var mouse_pos = get_local_mouse_position()
	
	if(mouse_pos.x > 0 && mouse_pos.x < _viewport.size.x):
		if(mouse_pos.y > 0 && mouse_pos.y < _viewport.size.y):
			if Input.is_mouse_button_pressed(BUTTON_LEFT):
				_pen.draw_circle(mouse_pos, _pen_size, _settings.color)
				_pen.draw_line(mouse_pos, _prev_mouse_pos, _settings.color, _pen_size * 2)
				
	_prev_mouse_pos = mouse_pos

func _on_resized():
	_viewport.size = get_rect().size
	update_pen_size()
	
func _exit_tree():
	_score_calculator.dispose()

##### Helpful functions #####
func init_main_texture_viewport(): 
	set_viewport()
	
	main_texture_rect.set_texture(_viewport.get_texture())
	
func init_handlers():
	_pen.connect("draw", self, "_on_draw")
	
	connect("resized", self, "_on_resized")
	
	GameEvents.connect("settings_initialized", self, "_on_settings_initialized")
	GameEvents.connect("finished", self, "_on_finished")
	GameEvents.connect("refreshed", self, "_on_refreshed")

func set_viewport():
	_viewport = Viewport.new()
	
	_viewport.set_transparent_background(true)
	_viewport.set_size(get_rect().size)
	_viewport.set_usage(Viewport.USAGE_2D)
	_viewport.set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)
	_viewport.set_vflip(true)
	_viewport.add_child(_pen)
	
	add_child(_viewport)
	
func update_pen_size():
	if(!_settings):
		return
	
	_pen_size = _settings.pen_size
	
	if(_viewport):
		_pen_size *= (_viewport.size.x + _viewport.size.y) / 2
