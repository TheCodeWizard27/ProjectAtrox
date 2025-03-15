extends ChaserEnemyState

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	chaser_enemy.chase(delta);
	pass
