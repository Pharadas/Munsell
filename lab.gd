@tool
extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Mirror4.global_position.x += 0.000001;
	#$Mirror4.rotation.y += 0.0001
	# calculate the path of the laser
	var space_state = get_world_3d().direct_space_state

	var initial_position = $LaserSource.global_position
	var final_position = $LaserSource.global_position - Vector3(0, 0, 100)

	var vertices = PackedVector3Array()

	var light_sources_wall = PackedVector3Array()
	var light_distances = PackedFloat32Array()

	var laser_collided = true
	var laser_check_queue = [[initial_position, final_position, 0.0]]

	while not laser_check_queue.is_empty():
		var curr_positions = laser_check_queue.pop_front()

		initial_position = curr_positions[0]
		final_position = curr_positions[1]

		var collision_query = PhysicsRayQueryParameters3D.create(initial_position, final_position)
		collision_query.collide_with_bodies = true

		var result = space_state.intersect_ray(collision_query)

		if not result.is_empty():
			var curr_distance = curr_positions[2] + (result["position"] - initial_position).length()

			vertices.push_back(initial_position)
			vertices.push_back(result["position"])

			var new_dir: Vector3

			match result["collider"].name:
				"MirrorMesh":
					var d: Vector3 = result["position"] - initial_position
					new_dir = d - 2 * (d.dot(result["normal"])) * result["normal"]

					initial_position = result["position"]
					final_position = result["position"] + new_dir * 1000

					laser_check_queue.push_back([initial_position, final_position, curr_distance])

				"BeamSplitter":
					laser_check_queue.push_back([result["position"], final_position, curr_distance])
					# reflected
					var d: Vector3 = result["position"] - initial_position
					new_dir = d - 2 * (d.dot(result["normal"])) * result["normal"]

					initial_position = result["position"]
					final_position = result["position"] + new_dir * 1000

					laser_check_queue.push_back([initial_position, final_position, curr_distance])

				"BeamSplitter2":
					laser_check_queue.push_back([result["position"], final_position, curr_distance])
					# reflected
					var d: Vector3 = result["position"] - initial_position
					new_dir = d - 2 * (d.dot(result["normal"])) * result["normal"]

					initial_position = result["position"]
					final_position = result["position"] + new_dir * 1000

					laser_check_queue.push_back([initial_position, final_position, curr_distance])

				"SimulationWall":
					light_sources_wall.push_back(result["position"])
					light_distances.push_back(curr_distance)
					#print(curr_positions[2] + (result["position"] - initial_position).length())

				"LaserSource":
					pass

				_:
					pass

		else:
			vertices.push_back(initial_position)
			vertices.push_back(final_position)
			#break

	var arr_mesh = ArrayMesh.new()
	var arrays = []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices

	#print(light_distances)

	$SimulationWall.get_child(0).material.set_shader_parameter("light_positions", light_sources_wall)
	$SimulationWall.get_child(0).material.set_shader_parameter("light_distances", light_distances)
	$SimulationWall.get_child(0).material.set_shader_parameter("num_of_light_sources", len(light_sources_wall))

	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_LINES, arrays)

	$Laser.get_children()[0].mesh = arr_mesh
