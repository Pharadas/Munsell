@tool
extends Node3D

var rng: RandomNumberGenerator

@export var init_pos: Vector3 = Vector3(0, 0, -1)
@export var final_pos: Vector3 = Vector3(0, 0, 1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng = RandomNumberGenerator.new()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#var a = rng.randf_range(-10.0, 10.0)
	#var b = rng.randf_range(-10.0, 10.0)
	#var c = rng.randf_range(-10.0, 10.0)
	#var d = rng.randf_range(-10.0, 10.0)
	#var f = rng.randf_range(-10.0, 10.0)
	#var g = rng.randf_range(-10.0, 10.0)
	#var h = rng.randf_range(-10.0, 10.0)
	#var i = rng.randf_range(-10.0, 10.0)
	#var j = rng.randf_range(-10.0, 10.0)
	#var k = rng.randf_range(-10.0, 10.0)
	#var l = rng.randf_range(-10.0, 10.0)
	#var m = rng.randf_range(-10.0, 10.0)
	#var n = rng.randf_range(-10.0, 10.0)
	#var o = rng.randf_range(-10.0, 10.0)
	#var p = rng.randf_range(-10.0, 10.0)
#
	#var vertices = PackedVector3Array()
	#vertices.push_back(Vector3(a, b, c))
	#vertices.push_back(Vector3(d, f, g))
	#vertices.push_back(Vector3(h, i, j))
	#vertices.push_back(Vector3(k, l, m))
	#vertices.push_back(Vector3(n, o, p))
#
	## Initialize the ArrayMesh.
	#var arr_mesh = ArrayMesh.new()
	#var arrays = []
	#arrays.resize(Mesh.ARRAY_MAX)
	#arrays[Mesh.ARRAY_VERTEX] = vertices
#
	## Create the Mesh.
	#arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_LINES, arrays)
	#$MeshInstance3D.mesh = arr_mesh

	#var mesh_instance := MeshInstance3D.new()
	#var immediate_mesh := ImmediateMesh.new()
	#var material := ORMMaterial3D.new()
#
	#mesh_instance.mesh = immediate_mesh
#
	#immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	#immediate_mesh.surface_add_vertex(init_pos)
	#immediate_mesh.surface_add_vertex(final_pos)
	#immediate_mesh.surface_end()
#
	#material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	#material.albedo_color = Color(1, 0, 0, 1)
#
	#get_tree().get_root().add_child.call_deferred(mesh_instance)
#
	#print(get_tree().get_root().get_children())
