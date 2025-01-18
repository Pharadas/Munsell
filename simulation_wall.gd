@tool
extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var a = $SimulationWall.global_transform * $SimulationWall.mesh.get_faces()[0]
	var b = $SimulationWall.global_transform * $SimulationWall.mesh.get_faces()[1]
	var c = $SimulationWall.global_transform * $SimulationWall.mesh.get_faces()[2]
	var d = $SimulationWall.global_transform * $SimulationWall.mesh.get_faces()[4]

	$CSGSphere3D.global_position = a
	$CSGSphere3D2.global_position = b
	$CSGSphere3D3.global_position = c
	$CSGSphere3D4.global_position = d

	var positions = PackedVector3Array([a, b, c, d])

	$SimulationWall.material.set_shader_parameter("vertex_positions", positions)
