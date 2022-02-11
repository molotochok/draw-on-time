extends Control

class_name UpDownMover

enum MoveDirection {
	DOWN = -1
	IDLE = 0,
	UP = 1,
}

export(float) var step := 1.0
export(float) var max_offset_up := 8
export(float) var max_offset_down := 8
export(bool) var should_stop := true
# Only if a node is resized in a greater amount then the _on_resized handler will be invoked
export(Vector2) var resize_threshold := Vector2(0.01, 0.01)
export(MoveDirection) var move_dir := MoveDirection.IDLE

onready var _parent: Control = get_parent() as Control
onready var _initial_parent_pos: Vector2

onready var _prev_size: Vector2 = get_rect().size

func _ready():
	update_initial_parent_pos()

	assert(connect("resized", self, "_on_resized") == OK)

func _physics_process(delta):
	if (move_dir == MoveDirection.UP):
		move_up(delta)
	
	if (move_dir == MoveDirection.DOWN):
		move_down(delta)

func _on_resized():
	var size = get_rect().size
	if abs(_prev_size.x - size.x) >= resize_threshold.x || \
		 abs(_prev_size.y - size.y) >= resize_threshold.y:
		update_initial_parent_pos()
	
	_prev_size = size

func move_up(delta):
	var pos = _parent.get_rect().position
	
	if(_initial_parent_pos.y - pos.y >= max_offset_up):
		move_dir = MoveDirection.IDLE if should_stop else MoveDirection.DOWN
	else:
		_parent.set_position(Vector2(pos.x, pos.y - step * delta))

func move_down(delta):
	var pos = _parent.get_rect().position
	
	if pos.y - _initial_parent_pos.y >= max_offset_down:
		move_dir = MoveDirection.IDLE if should_stop else MoveDirection.UP
	else:
		_parent.set_position(Vector2(pos.x, pos.y + step * delta))

func update_initial_parent_pos():
	_initial_parent_pos = _parent.get_rect().position	
