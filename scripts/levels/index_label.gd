extends Label

func _ready():
	connect("resized", self, "_on_resized")

func _on_resized():
	var font: DynamicFont = get_font("level_button_index_font")
	var size = OS.get_window_size()
	
	font.size = int(Math.linear_extrapolation(size.x, 815, 10, 1500, 20))
	
	add_font_override("level_button_index_font", font)
