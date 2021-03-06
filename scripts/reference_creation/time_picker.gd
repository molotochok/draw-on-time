extends TextEdit

func _ready():
	connect("text_changed", self, "_on_text_changed")
	GameEvents.connect("settings_initialized", self, "_on_settings_initialized")
	
func _on_text_changed():
	GameEvents.emit_signal("time_changed", float(text))
	
func _on_settings_initialized(settings: Settings):
	if(float(text) == settings.time):
		return
	
	set_text(str(settings.time))
