extends Control

func _ready():
  GameEvents.connect("drawing_started", self, "_on_drawing_started")
  GameEvents.connect("refreshed", self, "_on_refreshed")

  show()

func _on_drawing_started():
  hide()

func _on_refreshed():
  show()