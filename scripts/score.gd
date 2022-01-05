extends Control

export(NodePath) onready var stars_container = get_node(stars_container)

func _ready():
	GameEvents.connect("score_calculated", self, "_on_score_calculated")
	
func _on_score_calculated(score: float):
	var stars = stars_container.get_children()
	
	# Todo: get rid of code duplication
	if(score >= 50):
		stars[0].set_visible(true)
	
	if(score >= 75):
		stars[1].set_visible(true)
		
	if(score >= 90):
		stars[2].set_visible(true)
