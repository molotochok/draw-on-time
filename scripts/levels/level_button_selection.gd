extends Control

enum MoveDirection {
	DOWN = -1
	IDLE = 0,
	UP = 1,
}

export var _step := 1
export var _max_offset := 8

var _move_dir = MoveDirection.IDLE

onready var _parent: LevelButton = get_parent() as LevelButton
var _initial_parent_pos: Vector2

func _ready():
	update_initial_parent_pos()
	
	assert(connect("resized", self, "_on_resized") == OK)
	assert(connect("mouse_entered", self, "_on_mouse_entered") == OK)
	assert(connect("mouse_exited", self, "_on_mouse_exited") == OK)

func _physics_process(_delta):
	if (_move_dir == MoveDirection.UP):
		move_up()
	
	if (_move_dir == MoveDirection.DOWN):
		move_down()
		
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

func move_up():
	var pos = _parent.get_rect().position
	
	if(abs(_initial_parent_pos.y - pos.y) >= _max_offset):
		_move_dir = MoveDirection.IDLE
	else:
		_parent.set_position(Vector2(pos.x, pos.y - _step))

func move_down():
	var pos = _parent.get_rect().position
	
	if(_initial_parent_pos.y == pos.y):
		_move_dir = MoveDirection.IDLE
	else:
		_parent.set_position(Vector2(pos.x, pos.y + _step))
