extends CanvasLayer

@onready var player: Player = $".."
@onready var label: Label = $Control/Label
@onready var health_bar: ProgressBar = $Control/ProgressBar


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = str(player.curr_ammo) + "/" + str(player.max_ammo)
	health_bar.value = player.health
