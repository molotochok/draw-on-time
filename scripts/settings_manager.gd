extends Control

export(Resource) onready var settings = settings as Settings

func _ready():
	print(settings.time)
	GameEvents.emit_signal("settings_initialized", settings)
