extends Reference

class_name Math

static func linear_extrapolation(x: float, \
  start: Vector2, \
  end: Vector2) -> float:
	return start.y + ((x - start.x) / (end.x - start.x)) * (end.y - start.y)
