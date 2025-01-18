extends Sprite2D

var snapshotTexture

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	snapshotTexture = $"../SubViewport".get_texture()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$"../SubViewport/TextureRect".texture = snapshotTexture
	var frameData: Image = $"../SubViewport/TextureRect"tt.get_texture().get_image()
	var snapshotTexture := ImageTexture.new()
	snapshotTexture.create_from_image(frameData)
