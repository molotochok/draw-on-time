extends Resource

class_name Settings

export(float) var time = 10
export(float) var pen_size = 0.05
export(Color) var color = Color.white
export(Texture) var ref_texture

# TODO: Not sure that I need this here. 
# TODO: Maybe it would be better to move this into a seperate file
export(int) var index = 1
export(float) var score = 0.0
export(bool) var opened = false

# TODO: Not sure that this belongs here
func get_stars():
	if(score >= 50 && score < 75):
		return 1
	
	if(score >= 75 && score < 90):
		return 2
		
	if(score >= 90):
		return 3
	
	return 0
