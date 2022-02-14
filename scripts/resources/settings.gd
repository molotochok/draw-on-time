extends Resource

class_name Settings

export(float) var time := 10.0
export(Color) var color := Color.white
export(int) var index := 1
export(float) var pen_size := 0.05

# Pen Size Changing Feature
export(bool) var can_change_pen_size := false
export(float) var pen_size_step := 0.005
export(float) var pen_size_min := 0.02
export(float) var pen_size_max := 0.08

func increase_pen_size():
	if !can_change_pen_size:
		return

	pen_size = clamp(pen_size + pen_size_step, pen_size_min, pen_size_max)

func decrease_pen_size():
	if !can_change_pen_size:
		return

	pen_size = clamp(pen_size - pen_size_step, pen_size_min, pen_size_max)

var _stats: Stats
func get_stats() -> Stats:
	if !_stats:
		_stats = ResourceLoader.load(Paths.STATS % index) \
			if ResourceLoader.exists(Paths.STATS % index) \
			else Stats.new(index)

	return _stats

var _ref_texture : Texture
func get_ref_texture() -> Texture:
	if !_ref_texture:
		_ref_texture = ResourceLoader.load(Paths.SPRITE_REFERENCES % index)
	
	return _ref_texture

var _ref_preview_texture : Texture
	
func get_ref_preview_texture() -> Texture:
	if !_ref_preview_texture:
		_ref_preview_texture = ResourceLoader.load(Paths.SPRITE_PREVIEW_REFERENCES % index)
	
	return _ref_preview_texture
