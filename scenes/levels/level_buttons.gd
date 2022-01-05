extends GridContainer


func _ready():
	var level_buttons = get_children()
	
	# TODO: This logic should not be in this script
	# TODO: Maybe this could be done more efficient
	# TODO: magic number
	# TODO: implement pagination of substracting batch_size from the scene count
	var batch_size = 18
	
	for i in range(1, SceneManager.scene_count + 1):
		var setting = load(Paths.MAIN_SETTING % i)
		level_buttons[i - 1].update_settings(setting, i)
		level_buttons[i - 1].set_modulate(Color.white)
	
