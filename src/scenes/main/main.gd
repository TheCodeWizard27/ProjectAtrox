extends Node3D

@export var body: RigidBody3D
@export var height_map: Texture2D

@onready var map_collider: CollisionShape3D = $"StaticBody3D/CollisionShape3D"

func _ready() -> void:
	var image = height_map.get_image()
	image.decompress()
	image.convert(Image.FORMAT_RF)
	(map_collider.shape as HeightMapShape3D).update_map_data_from_image(image, 0.0, 10.0)

func _process(delta: float) -> void:
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * 1000 * delta
	body.apply_force(Vector3(input_direction.x, 0, input_direction.y))
