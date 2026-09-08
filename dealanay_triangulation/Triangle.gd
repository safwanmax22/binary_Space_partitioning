class_name Triangle extends Resource

@export var points: Array[Vector2]

func hashcode() -> String:
	points.sort()
	return str(points)


func equals(other: Triangle) -> bool:
	return hashcode() == other.hashcode()
