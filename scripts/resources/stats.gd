extends Resource

class_name Stats

export(int) var index
export(float) var score
export(bool) var opened

func _init(index = 1, score = 0.0, opened = index == 1):
  self.index = index
  self.score = score
  self.opened = opened

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