extends Node

var current_scene = 1
onready var scene_count = FileManager.files_in_directory(Paths.MAIN_SETTINGS)

func _ready():
	GameEvents.connect("scene_changed", self, "_on_scene_changed")
	GameEvents.connect("new_settings_created", self, "_on_new_settings_created")

func _on_scene_changed():
	current_scene += 1
	
	if(current_scene > scene_count):
		current_scene = 1
		
	get_tree().change_scene(Paths.MAIN_LEVEL)
	
func _on_new_settings_created():
	scene_count += 1
	print(scene_count)
	
