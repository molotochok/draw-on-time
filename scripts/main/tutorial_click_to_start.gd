extends Control

func _ready():
  assert(GameEvents.connect("drawing_started", self, "_on_drawing_started") == OK)
  assert(GameEvents.connect("refreshed", self, "_on_refreshed") == OK)

  show()

func _on_drawing_started():
  hide()

func _on_refreshed():
  show()