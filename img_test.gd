extends MeshInstance3D

@onready var colors_view_port: SubViewport = $"../ColorsViewPort"
@onready var stitches_viewport: SubViewport = $"../StitchesViewport"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stitches_viewport.world_2d = colors_view_port.world_2d
