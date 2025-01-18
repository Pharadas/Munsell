@tool
extends Node3D

#self.material.set_shader_parameter("world_position", self.global_position)

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#var mdt = MeshDataTool.new()
	#mdt.create_from_surface($blocker.mesh, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var rng = RandomNumberGenerator.new()

	var a = $blocker.global_transform * $blocker.mesh.get_faces()[0]
	var b = $blocker.global_transform * $blocker.mesh.get_faces()[1]
	var c = $blocker.global_transform * $blocker.mesh.get_faces()[2]
	var d = $blocker.global_transform * $blocker.mesh.get_faces()[4]
#
	#$a.global_position = a
	#$b.global_position = b
	#$c.global_position = c
	#$d.global_position = d

	var positions = PackedVector3Array([a, b, c, d])

	$SubViewport/ColorRect.material.set_shader_parameter("vertex_positions", positions)
	$SubViewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS

	#print($SubViewport.get_texture())

	a = $wall.global_transform * $wall.mesh.get_faces()[0]
	b = $wall.global_transform * $wall.mesh.get_faces()[1]
	c = $wall.global_transform * $wall.mesh.get_faces()[2]
	d = $wall.global_transform * $wall.mesh.get_faces()[4]

	positions = PackedVector3Array([a, b, c, d])

	$wall.material.set_shader_parameter("vertex_positions", positions)
	$wall.material.set_shader_parameter("blockerPositions", $SubViewport.get_texture())

	#if rng.randi_range(0, 100) == 0:
		#print($SubViewport.get_texture().get_image().get_format())

	#var MODELVIEW: Transform3D = $blocker.global_transform * get_viewport().get_camera_3d().get_camera_transform() 
	##print(MODELVIEW * $blocker.mesh.get_faces()[0])
#
	#$blocker.rotate_x(0.01)
	#$blocker.rotate_y(0.01)
	#$blocker.rotate_z(0.01)

	#print($blocker.mesh.get_faces()[0] * $blocker.global_transform)
