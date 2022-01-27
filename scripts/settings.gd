extends Resource

class_name Settings

export(float) var time = 10
export(float) var pen_size = 0.05
export(Color) var color = Color.white
export(int) var index = 1
export(float) var score = 0.0
export(bool) var opened = false

var _ref_texture : Texture
var _ref_preview_texture : Texture

func get_stars() -> int:
	if(score >= 50 && score < 75):
		return 1
	
	if(score >= 75 && score < 90):
		return 2
		
	if(score >= 90):
		return 3
	
	return 0

func passed() -> bool:
  return get_stars() > 0

func get_ref_texture() -> Texture:
	if(!_ref_texture):
		_ref_texture = load(Paths.SPRITE_REFERENCES % index)
	
	return _ref_texture
	
func get_ref_preview_texture() -> Texture:
	if(!_ref_preview_texture):
		_ref_preview_texture = load(Paths.SPRITE_PREVIEW_REFERENCES % index)
	
	return _ref_preview_texture
