extends Control

export(NodePath) onready var label = get_node(label) as Label
export(NodePath) onready var anim_player = get_node(anim_player) as AnimationPlayer
export(Resource) onready var finish_messages = finish_messages as FinishMessages

export(Array, Color) onready var label_colors = label_colors as Array

func _ready():
  GameEvents.connect("score_calculated", self, "_on_score_calculated")
  GameEvents.connect("refreshed", self, "_on_refreshed")

  hide()

func _on_refreshed():
  hide()

func _on_score_calculated(score: float):
  show_message(Stats.get_stars_by(score))
  show_animated()

func show_animated():
  anim_player.play("finish_message_displayer")

func show_message(stars: int):
  label.text = "%s\n%s!" % [build_default_message(stars), get_message(stars)]
  label.modulate = label_colors[stars]

func build_default_message(stars: int) -> String:
  var message = "You've earned %s star" % str(stars)

  if stars != 1:
    message += "s"
  
  return message

func get_message(stars: int) -> String:
  var messages = finish_messages.messages[stars]
  return messages[randi() % messages.size()]