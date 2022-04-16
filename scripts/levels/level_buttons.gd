extends GridContainer

export(NodePath) onready var prev_btn = get_node(prev_btn) as TextureButton
export(NodePath) onready var next_btn = get_node(next_btn) as TextureButton

onready var _page_size := get_children().size()
onready var _page_index := 0
onready var _min_page_index := 0
onready var _max_page_index := int(LevelManager.level_count / _page_size)

func _ready():
	change_page(_page_index)

	GameEvents.connect("prev_level_page_clicked", self, "_on_prev_level_page_clicked")
	GameEvents.connect("next_level_page_clicked", self, "_on_next_level_page_clicked")

func _on_prev_level_page_clicked():
	change_page(_page_index - 1)

func _on_next_level_page_clicked():
	change_page(_page_index + 1)

func change_page(new_page_index: int):
	_page_index = int(clamp(new_page_index, _min_page_index, _max_page_index))
	toggle_page_change_btns()
	load_levels()

func toggle_page_change_btns():
	prev_btn.toggle_visibility(_page_index != 0, true)
	next_btn.toggle_visibility((_page_index + 1) * _page_size < LevelManager.level_count, true)

func load_levels():
	var level_buttons = get_children()
	
	var prev_settings: Settings = null
	for i in range(1, _page_size + 1):
		level_buttons[i - 1].toggle_visibility(false, true)
	
		var index = i + _page_index * _page_size
		if(index >= LevelManager.level_count + 1):
			continue

		var settings: Settings = load(Paths.MAIN_SETTING % index) \
			if prev_settings == null || prev_settings.get_stats().opened \
			else null
		
		prev_settings = settings

		level_buttons[i - 1].update_settings(settings, index)
		level_buttons[i - 1].toggle_visibility(true, false)
