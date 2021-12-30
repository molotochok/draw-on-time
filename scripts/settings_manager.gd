extends Control

export(Resource) onready var settings
export(bool) var load_from_resource = true

func _ready():
	if(load_from_resource):
		settings = load(Paths.MAIN_SETTING % SceneManager.current_scene)
	
	GameEvents.connect("pen_size_changed", self, "_on_pen_size_changed")
	GameEvents.connect("time_changed", self, "_on_time_changed")
	
	_initialized()
	
func _on_pen_size_changed(size: float):
	settings.pen_size = size
	_initialized()
	
func _on_time_changed(time: float):
	settings.time = time
	_initialized()
	
func _initialized():
	GameEvents.emit_signal("settings_initialized", settings)
