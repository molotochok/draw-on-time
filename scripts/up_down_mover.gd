extends Control

class_name UpDownMover

enum MoveDirection {
	DOWN = -1
	IDLE = 0,
	UP = 1,
}

export(float) var _step := 1.0
export(int) var _max_offset := 8
export(bool) var should_stop := true
export(MoveDirection) var _move_dir := MoveDirection.IDLE

onready var _parent: Control = get_parent() as Control
onready var _initial_parent_pos: Vector2

func _ready():
  update_initial_parent_pos()

func _physics_process(delta):
	if (_move_dir == MoveDirection.UP):
		move_up(delta)
	
	if (_move_dir == MoveDirection.DOWN):
		move_down(delta)
		
func move_up(delta):
	var pos = _parent.get_rect().position
	
	if(_initial_parent_pos.y - pos.y >= _max_offset):
		_move_dir = MoveDirection.IDLE if should_stop else MoveDirection.DOWN
	else:
		_parent.set_position(Vector2(pos.x, pos.y - _step * delta))

func move_down(delta):
	var pos = _parent.get_rect().position
	
	if pos.y - _initial_parent_pos.y >= _max_offset:
		_move_dir = MoveDirection.IDLE if should_stop else MoveDirection.UP
	else:
		_parent.set_position(Vector2(pos.x, pos.y + _step * delta))

func update_initial_parent_pos():
  _initial_parent_pos = _parent.get_rect().position	
