extends Button

func _ready():
	GameEvents.connect("finished", self, "_on_finished")

func _pressed():
	GameEvents.emit_signal("refreshed")
	
func _on_finished():
	set_disabled(true)
