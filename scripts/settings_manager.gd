extends Control

export(Resource) onready var settings
export(bool) var load_from_resource = true

func _ready():
  if(load_from_resource):
	  settings = load(Paths.MAIN_SETTING % LevelManager.current_level)

  assert(GameEvents.connect("pen_size_changed", self, "_on_pen_size_changed") == OK)
  assert(GameEvents.connect("time_changed", self, "_on_time_changed") == OK)
  assert(GameEvents.connect("score_calculated", self, "_on_score_calculated") == OK)
  assert(GameEvents.connect("settings_save_requested", self, "_on_settings_save_requested") == OK)
  
  _initialized()
	
func _on_pen_size_changed(size: float):
	settings.pen_size = size
	_initialized()
	
func _on_time_changed(time: float):
	settings.time = time
	_initialized()

func _on_score_calculated(score: float):
  if(score <= settings.score):
    return
    
  settings.score = score
  save(settings) 

  if settings.passed() && LevelManager.current_level != LevelManager.level_count:
    var next_settings = load(Paths.MAIN_SETTING % str(LevelManager.current_level + 1))
    if !next_settings.opened:
      next_settings.opened = true;
      save(next_settings)

func _on_settings_save_requested(new_settings: Settings):
  save(new_settings)

func _initialized():
	GameEvents.emit_signal("settings_initialized", settings)

func save(target_settings = settings):
  if ResourceSaver.save(Paths.MAIN_SETTING % target_settings.index, target_settings) != OK:
    printerr("A problem occured during saving the setting.")
    return

  if(target_settings == settings):
    GameEvents.emit_signal("settings_updated", target_settings)

  if(target_settings.index > LevelManager.level_count):
    LevelManager.increment_level_count()
  
