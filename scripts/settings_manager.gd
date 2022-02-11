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
	var stats = settings.get_stats()
	if(score <= stats.score):
		return
		
	stats.score = score
	save_stats(stats) 
	try_open_next_stats(stats)

func _on_settings_save_requested(new_settings: Settings):
	save_settings(new_settings)

func _initialized():
	GameEvents.emit_signal("settings_initialized", settings)

func save_settings(target_settings = settings):
	assert(ResourceSaver.save(Paths.MAIN_SETTING % target_settings.index, target_settings) == OK)

	if(target_settings == settings):
		GameEvents.emit_signal("settings_updated", target_settings)

	if(target_settings.index > LevelManager.level_count):
		LevelManager.increment_level_count()

func save_stats(stats: Stats):
	assert(ResourceSaver.save(Paths.STATS % stats.index, stats) == OK)

	if(stats.index == settings.index):
		GameEvents.emit_signal("stats_updated", stats)

func try_open_next_stats(stats: Stats):
	if !stats.passed() || LevelManager.current_level >= LevelManager.level_count:
		return

	var next_stats_index = LevelManager.current_level + 1
	var next_stats = Stats.new(next_stats_index, 0.0, true)

	var next_stats_path = Paths.STATS % str(next_stats_index)
	if !ResourceLoader.exists(next_stats_path):
		save_stats(next_stats)
		return
		
	next_stats = ResourceLoader.load(next_stats_path)

	if !next_stats.opened:
		next_stats.opened = true;
		save_stats(next_stats)
