extends UpDownMover

func _ready():
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")

	_parent = _parent as LevelButton
		
func _on_mouse_entered():
	if interactable():
		move_dir = MoveDirection.UP

func _on_mouse_exited():
	if interactable():
		move_dir = MoveDirection.DOWN

func interactable() -> bool:
	return modulate.a > 0 && _parent.opened()

