extends Control

export(NodePath) onready var texture_rect = get_node(texture_rect) as TextureRect
export(NodePath) onready var anim_player = get_node(anim_player) as AnimationPlayer

export(Resource) onready var star_texture

func show_star(should_animate: bool):
	if should_animate:
		anim_player.play("score_appearance")
	else:
		texture_rect.set_texture(star_texture)
