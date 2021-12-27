extends Control

export(NodePath) onready var ref_texture_rect = get_node(ref_texture_rect) as TextureRect
export(NodePath) onready var main_texture_rect = get_node(main_texture_rect) as TextureRect

onready var _pen := Node2D.new()
# These values are overriden by settings if specified
var _pen_size := 10.0
var _pen_color := Color.red

var _prev_mouse_pos := Vector2()
var _can_draw := true
var _viewport: Viewport

var _score_calculator := ScoreCalculator.new()

##### Main handlers #####
func _ready():
	init_main_texture_viewport()
	init_handlers()

func _process(delta):
	if(_can_draw):
		_pen.update()
	
	if(Input.is_action_just_pressed("capture_image")):
		var image = main_texture_rect.get_texture().get_data()
		image.save_png("img.png")


##### Custom handlers #####
func _on_refreshed():
	_viewport.set_clear_mode(Viewport.CLEAR_MODE_ALWAYS)
	_viewport.set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)

func _on_finished():
	finish()

func _on_settings_initialized(settings: Settings):
	ref_texture_rect.set_texture(settings.ref_texture)
	main_texture_rect.get_material().set_shader_param("reference", settings.ref_texture)
	
	_pen_color = settings.color
	_pen_size = settings.pen_size

func _on_draw():
	var mouse_pos = get_local_mouse_position()
	
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		_pen.draw_circle(mouse_pos, _pen_size, _pen_color)
		_pen.draw_line(mouse_pos, _prev_mouse_pos, _pen_color, _pen_size * 2)

	_prev_mouse_pos = mouse_pos

func _on_resized():
	_viewport.size = get_rect().size
	
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

func finish():
	_can_draw = false
	_score_calculator.calculate(main_texture_rect, ref_texture_rect)
	
