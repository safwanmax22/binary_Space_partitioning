class_name Triangle extends Resource

@export var points: Array[Vector2]


func equals(other: Triangle) -> bool:
	points.sort()
	other.points.sort()
	
	if points.size() != other.points.size():
		return false
		
	for i in points.size():
		if !((points[i] - other.points[i]) as Vector2).is_zero_approx():
			return false
	
	return true
