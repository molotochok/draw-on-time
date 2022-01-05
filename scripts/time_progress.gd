extends TextureRect

export(NodePath) onready var timer = get_node(timer) as Timer

export(bool) var dont_finish = false

func _ready():
	GameEvents.connect("settings_initialized", self, "_on_settings_initialized")
	GameEvents.connect("time_changed", self, "_on_time_changed")
	GameEvents.connect("refreshed", self, "_on_refreshed")
	GameEvents.connect("finished", self, "_on_finished")	

func _process(delta):
	update_progress("curr_time")

func _on_settings_initialized(settings: Settings):
	update_wait_time(settings.time)
	
func _on_time_changed(time: float):
	update_wait_time(time)

func _on_refreshed():
	timer.start()
	
func _on_finished():
	timer.set_paused(true)
	
func update_wait_time(time):
	timer.set_wait_time(time)
	timer.start()
	
	update_progress("max_time")

func update_progress(param_name):
	var time_left = timer.get_time_left()
	get_material().set_shader_param(param_name, time_left)

func _on_Timer_timeout():
	if(dont_finish):
		return
		
	GameEvents.emit_signal("finished")
