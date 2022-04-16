extends Control

class_name DrawingCanvas

const _PEN_CURSOR_COLOR := Color(0, 0, 0, 0.45)

export(NodePath) onready var ref_texture_rect = get_node(ref_texture_rect) as TextureRect
export(NodePath) onready var main_texture_rect = get_node(main_texture_rect) as TextureRect
# Used to display pen cursor
export(NodePath) onready var pen_cursor = get_node(pen_cursor) as Control

onready var _pen := Node2D.new()
onready var _pen_size := 10.0

var _settings: Settings

var _prev_mouse_pos := Vector2()
var _can_draw := true
var _drawing_started := false
var _viewport: Viewport

var _score_calculator := ScoreCalculator.new()

##### Main handlers #####
func _ready():
	init_main_texture_viewport()
	init_handlers()

	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _physics_process(_delta):
	pen_cursor.update()

	if(_can_draw):
		_pen.update()

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() && _settings.can_change_pen_size:
			if event.button_index == BUTTON_WHEEL_UP:
				_settings.decrease_pen_size()
				update_pen_size()
			if event.button_index == BUTTON_WHEEL_DOWN:
				_settings.increase_pen_size()
				update_pen_size()

##### Custom handlers #####
func _on_refreshed():
	_viewport.set_clear_mode(Viewport.CLEAR_MODE_ALWAYS)
	_viewport.set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)

	if !_can_draw:
		_can_draw = true

	_drawing_started = false

func _on_finished():
	_can_draw = false
	_score_calculator.calculate(main_texture_rect, ref_texture_rect)

func _on_settings_initialized(settings: Settings):
	_settings = settings
	
	init_ref_texture()
	main_texture_rect.get_material().set_shader_param("reference", settings.get_ref_texture())
	
	update_pen_size()	

func _on_draw():
	var mouse_pos = get_local_mouse_position()
	
	if is_mouse_in_viewport(mouse_pos):
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			if !_drawing_started:
				GameEvents.emit_signal("drawing_started")
				_drawing_started = true

			_pen.draw_circle(mouse_pos, _pen_size, _settings.color)
			_pen.draw_line(mouse_pos, _prev_mouse_pos, _settings.color, _pen_size * 2)
				
	_prev_mouse_pos = mouse_pos

func _on_pen_cursor_draw():
	var mouse_pos = get_local_mouse_position()

	if is_mouse_in_viewport(mouse_pos):
		if(Input.get_mouse_mode() != Input.MOUSE_MODE_HIDDEN):
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

		pen_cursor.draw_circle(mouse_pos, _pen_size, _PEN_CURSOR_COLOR)
	else:
		if(Input.get_mouse_mode() != Input.MOUSE_MODE_VISIBLE):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_resized():
	update_pen_size()
	
##### Helpful functions #####
func init_main_texture_viewport(): 
	set_viewport()
	
	main_texture_rect.set_texture(_viewport.get_texture())
	
func init_handlers():
	_pen.connect("draw", self, "_on_draw")
	pen_cursor.connect("draw", self, "_on_pen_cursor_draw")
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

func is_mouse_in_viewport(mouse_pos: Vector2) -> bool:
	return mouse_pos.x > 0 && mouse_pos.x < _viewport.size.x \
			&& mouse_pos.y > 0 && mouse_pos.y < _viewport.size.y

func init_ref_texture():
	ref_texture_rect.set_texture(_settings.get_ref_texture())

	if !_settings.can_toggle_ref:
		return

	yield(get_tree().create_timer(_settings.ref_toggle_start_time), "timeout")
	
	var iteration = 1
	var factor = -1
	while(_settings.ref_toggle_iterations == -1 || iteration <= _settings.ref_toggle_iterations):
		ref_texture_rect.modulate.a += _settings.ref_toggle_step * factor

		if ref_texture_rect.modulate.a >= 1 || ref_texture_rect.modulate.a <= 0:
			factor *= -1

		$ToggleRefTimer.start(_settings.ref_toggle_step_time); yield($ToggleRefTimer, "timeout")

		iteration += 1
