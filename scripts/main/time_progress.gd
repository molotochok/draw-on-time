extends Control

export(NodePath) onready var inside_text_rect = get_node(inside_text_rect) as TextureRect

export(NodePath) onready var timer = get_node(timer) as Timer
export(bool) var dont_finish = false

func _ready():
	assert(GameEvents.connect("settings_initialized", self, "_on_settings_initialized") == OK)
	assert(GameEvents.connect("drawing_started", self, "_on_drawing_started") == OK)
	assert(GameEvents.connect("time_changed", self, "_on_time_changed") == OK)
	assert(GameEvents.connect("refreshed", self, "_on_refreshed") == OK)

func _process(_delta):
	update_curr_time()

func _on_settings_initialized(settings: Settings):
	update_max_time(settings.time)
	reset_timer()

func _on_time_changed(time: float):
	update_max_time(time)
	start_timer()

func _on_drawing_started():
	start_timer()

func _on_refreshed():
	reset_timer()

func start_timer():
	timer.set_paused(false)
	timer.start()

func reset_timer():
	timer.set_paused(true)
	timer.start()

func update_max_time(time):
	timer.set_wait_time(time)
	update_shaders("max_time", time)

func update_curr_time():
	var time_left = timer.get_time_left()
	update_shaders("curr_time", time_left)

func update_shaders(param_name, time_left):
	inside_text_rect.get_material().set_shader_param(param_name, time_left)

func _on_Timer_timeout():
	if(dont_finish):
		return
		
	GameEvents.emit_signal("finished")
