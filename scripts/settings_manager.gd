extends Control

export(Resource) onready var settings = settings as Settings

func _ready():
	GameEvents.emit_signal("settings_initialized", settings)
