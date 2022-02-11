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

static func get_stars_by(score: float) -> int:
	if(score >= 65 && score < 80):
		return 1

	if(score >= 80 && score < 95):
		return 2
	
	if(score >= 95):
		return 3

	return 0

func get_stars() -> int:
	return get_stars_by(score)

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
