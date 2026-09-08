class_name DelaunayTriangulation extends Node

const TRIANGULATION_EDGE = preload("uid://bix18ev8roj4q")


func triangulate(points: Array[Node2D]) -> Array[Triangle]:
	var triangles: Array[Triangle] = [get_super_triangle(points)]
	
	for point in points:
		var adding_point: Vector2 = point.position
		var bad_triangles: Array[Triangle] = []
		var updated_triangles: Array[Triangle] = []
		# check if the new point is making any of the triangle fail Delaunay triangulation
		for triangle in triangles:
			if !_is_delaunay_triangle(adding_point, triangle):
				updated_triangles.push_back(triangle)
			else:
				bad_triangles.push_back(triangle)
		
		var new_triangles: Dictionary[String, Triangle] = {}
		
		for bad_triangle in bad_triangles:
			var edge_a: Triangle = Triangle.new()
			var edge_b: Triangle = Triangle.new()
			var edge_c: Triangle = Triangle.new()
			
			edge_a.points = [
				bad_triangle.points[0],
				bad_triangle.points[1]
			]
			edge_b.points = [
				bad_triangle.points[1],
				bad_triangle.points[2]
			]
			edge_c.points = [
				bad_triangle.points[0],
				bad_triangle.points[2]
			]
			
			if new_triangles.has(edge_a.hashcode()):
				new_triangles.erase(edge_a.hashcode())
			else:
				new_triangles[edge_a.hashcode()] = edge_a
				
			if new_triangles.has(edge_b.hashcode()):
				new_triangles.erase(edge_b.hashcode())
			else:
				new_triangles[edge_b.hashcode()] = edge_b
				
			if new_triangles.has(edge_c.hashcode()):
				new_triangles.erase(edge_c.hashcode())
			else:
				new_triangles[edge_c.hashcode()] = edge_c
		
		for new_triangle in new_triangles.values():
			new_triangle.points.push_back(adding_point)
			updated_triangles.push_back(new_triangle)
		triangles = updated_triangles
		
	return triangles


func get_super_triangle(points: Array[Node2D]) -> Triangle:
	if points.is_empty():
		return null
	var margin: float = 50
	
	var lowest_x: float = points[0].position.x
	var highest_x: float = points[0].position.x
	var lowest_y: float = points[0].position.y
	var highest_y: float = points[0].position.y
	
	for point in points:
		if point.position.x < lowest_x:
			lowest_x = point.position.x
			
		if point.position.x > highest_x:
			highest_x = point.position.x
			
		if point.position.y < lowest_y:
			lowest_y = point.position.y
			
		if point.position.y > highest_y:
			highest_y = point.position.y
	
	# add margin
	lowest_x -= margin
	highest_x += margin
	lowest_y -= margin
	highest_y += margin
	
	var x_midpoint = (lowest_x + highest_x) / 2
	var boundary_size := Vector2(highest_x - lowest_x, highest_y - lowest_y)
	var super_triangle: Triangle = Triangle.new()
	
	super_triangle.points = [
		Vector2(x_midpoint, lowest_y - boundary_size.y), 
		Vector2(x_midpoint - boundary_size.x, highest_y), 
		Vector2(x_midpoint + boundary_size.x, highest_y)
	]
	
	return Triangle.new()


func _is_delaunay_triangle(point: Vector2, triangle: Triangle) -> bool:
	return true
