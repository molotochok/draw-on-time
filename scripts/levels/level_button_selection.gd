extends UpDownMover

func _ready():
	._ready()

	assert(connect("resized", self, "_on_resized") == OK)
	assert(connect("mouse_entered", self, "_on_mouse_entered") == OK)
	assert(connect("mouse_exited", self, "_on_mouse_exited") == OK)

	_parent = _parent as LevelButton
		
func _on_mouse_entered():
	if interactable():
		_move_dir = MoveDirection.UP

func _on_mouse_exited():
	if interactable():
		_move_dir = MoveDirection.DOWN

func _on_resized():
	update_initial_parent_pos()

func interactable() -> bool:
	return modulate.a > 0 && _parent.opened()

func update_initial_parent_pos():
	_initial_parent_pos = _parent.get_rect().position	
