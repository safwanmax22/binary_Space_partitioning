extends Node2D

@onready var delaunay_triangulation: DelaunayTriangulation = $DelaunayTriangulation

var points: Array[Node2D] = []
var super_triangle: Triangle

func _ready() -> void:
	var point_count := 20
	for i in point_count:
		var new_point := Node2D.new()
		new_point.position = Vector2(randi_range(500, 700), randi_range(500, 700))
		points.push_back(new_point)
		
	super_triangle = delaunay_triangulation.get_super_triangle(points)


func _draw():
	for point in points:
		draw_circle(point.position, 2, Color.AQUA)
		
	if super_triangle:
		var polygon: Array[Vector2] = [
			super_triangle.points[0],
			super_triangle.points[1],
			super_triangle.points[2],
			super_triangle.points[0]
		]
		draw_polyline(polygon, Color.RED)
