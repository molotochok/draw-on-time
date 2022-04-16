extends InteractableTextureButton

func _ready():
	toggle_disable(true)
	GameEvents.connect("drawing_started", self, "_on_drawing_started")

func _pressed():
	toggle_disable(true)
	GameEvents.emit_signal("refreshed")

func _on_drawing_started():
	toggle_disable(false)
