extends Control

enum MoveDirection {
	DOWN = -1
	IDLE = 0,
	UP = 1,
}

export var _step := 1
export var _max_offset := 8

var _move_dir = MoveDirection.IDLE

var _parent: Control
var _initial_parent_pos: Vector2

func _ready():
	_parent = get_parent()
	_initial_parent_pos = _parent.get_rect().position
	
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")

func _physics_process(delta):
	if (_move_dir == MoveDirection.UP):
		move_up()
	
	if (_move_dir == MoveDirection.DOWN):
		move_down()
		
func _on_mouse_entered():
	_move_dir = MoveDirection.UP

func _on_mouse_exited():
	_move_dir = MoveDirection.DOWN

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
