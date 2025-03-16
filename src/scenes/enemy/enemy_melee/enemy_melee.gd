extends "res://src/scenes/enemy/base_enemy/base_enemy.gd"

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var attack_box: Area3D = %AttackBox
@onready var health_bar: HealthBar = $CharacterBody3D/Healthbar/SubViewport/Control

func _ready() -> void:
	attack_box.body_entered.connect(_on_body_entered)
	health_bar.setup(max_health)
	current_health = max_health

func _process(delta: float) -> void:
	super._process(delta)
	health_bar.update(current_health)
	
	if(current_health > 0):
		return
	
	# Hacky way fix up in future
	process_mode = Node.PROCESS_MODE_DISABLED
	get_parent().remove_child(self)

func attack() -> void:
	animation_player.play("attack")
	
func _on_body_entered(body: Node3D) -> void:
	var parent = body.get_parent_node_3d()
	
	if("player" in parent.get_groups()):
		(parent as Player).get_hit(attack_damage, self.body)
