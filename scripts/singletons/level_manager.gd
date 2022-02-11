extends Node

var current_level := 1 setget set_current_level, get_current_level
onready var level_count = FileManager.files_in_directory(Paths.MAIN_SETTINGS) setget set_level_count, get_level_count

####### Setters and Getters ###### 
func set_current_level(_value: int):
  printerr("Can't set a current_level from outside of LevelManager.")

func get_current_level():
  return current_level


func set_level_count(_value: int):
  printerr("Can't set a level_count from outside of LevelManager.")

func get_level_count():
  return level_count


####### Public functions ###### 
func load_prev_level():
  current_level = int(max(current_level - 1, 1))
  load_main_level(current_level)

func load_next_level():
  current_level = int(min(current_level + 1, level_count))
  load_main_level(current_level)

func load_main_level(level = 1):
  current_level = level
  assert(get_tree().change_scene(Paths.MAIN_LEVEL) == OK)

func load_menu():
  assert(get_tree().change_scene(Paths.MENU) == OK)

func load_levels():
  assert(get_tree().change_scene(Paths.LEVELS) == OK)

func quit():
  # Closes the window tab in a Browser if HTML5
  if OS.has_feature('JavaScript'):
    JavaScript.eval("window.close()")
  get_tree().quit()
	
func increment_level_count():
	level_count += 1
	print("Level: " + str(level_count))
