extends Resource

class_name Settings

export(float) var time = 10
export(float) var pen_size = 0.05
export(Color) var color = Color.white
export(int) var index = 1

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
