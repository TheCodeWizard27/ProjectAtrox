extends "res://src/scenes/enemy/base_enemy/base_enemy.gd"

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var attack_box: Area3D = %AttackBox

func _ready() -> void:
	attack_box.body_entered.connect(_on_body_entered)

func attack() -> void:
	animation_player.play("attack")
	
func _on_body_entered(body: Node3D) -> void:
	var parent = body.get_parent_node_3d()
	
	if("player" in parent.get_groups()):
		(parent as Player).hit()
