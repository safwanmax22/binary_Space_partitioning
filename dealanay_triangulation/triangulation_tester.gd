extends Node2D

@onready var delaunay_triangulation: DelaunayTriangulation = $DelaunayTriangulation

var points: Array[Node2D] = []
var super_triangle: Triangle

var _draw_points: Array[Vector2] = []
var _draw_triangle: Array[Triangle] = []
var _draw_circle: Circle

func _input(event: InputEvent):
	if event.is_action_pressed("ui_accept"):
		delaunay_triangulation.next.emit()


func _ready():
	var point_count := 20
	for i in point_count:
		var new_point := Node2D.new()
		new_point.position = Vector2(randi_range(500, 700), randi_range(500, 700))
		points.push_back(new_point)
		
	delaunay_triangulation.triangulate(points)


func _draw():
	for point in _draw_points:
		draw_circle(point, 2, Color.AQUA)
	
	for triangle in _draw_triangle:
		var polygon: Array[Vector2] = [
			triangle.points[0],
			triangle.points[1],
			triangle.points[2],
			triangle.points[0]
		]
		draw_polyline(polygon, Color.GREEN)
		
	if _draw_circle:
		draw_circle(_draw_circle.position, _draw_circle.raidus, Color.RED, false)


func _on_delaunay_triangulation_circle_drawn(circle: Circle) -> void:
	_draw_circle = circle
	queue_redraw()


func _on_delaunay_triangulation_new_triangle_drawn(triangle: Array[Triangle]) -> void:
	_draw_triangle = triangle
	queue_redraw()


func _on_delaunay_triangulation_point_added(point: Vector2) -> void:
	_draw_points.push_back(point)
	queue_redraw()
