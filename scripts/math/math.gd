extends Reference

class_name Math

static func linear_extrapolation(x: float, \
	x1: float, y1: float, \
	x2: float, y2: float) -> float:
	return y1 + ((x - x1) / (x2 - x1)) * (y2 - y1)
