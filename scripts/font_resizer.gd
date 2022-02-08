extends Label

# Update size on resize variables
export var font_name: String = "font"
export var start_size: Vector2
export var end_size: Vector2

# Update size in a loop variables
export var should_update_size_in_loop: bool = false
export var size_offset := 1
export var size_step := 1
export var time = 0.5

onready var font: DynamicFont = get_font(font_name)

var current_size: int

func _ready():
	assert(connect("resized", self, "_on_resized") == OK)

	if should_update_size_in_loop:
		update_size_in_loop()

func update_size_in_loop():
	var direction := 1

	while true:
		font.size += size_step * direction

		if(font.size >= current_size + size_offset || font.size < current_size):
			direction *= -1
		
		add_font_override(font_name, font)

		$Timer.start(time); yield($Timer, "timeout")

func _on_resized():
	var size = OS.get_window_size()
	
	font.size = int(Math.linear_extrapolation(size.x, start_size, end_size))
	current_size = font.size

	add_font_override(font_name, font)
