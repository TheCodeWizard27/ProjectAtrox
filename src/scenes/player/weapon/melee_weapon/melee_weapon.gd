extends Weapon

@onready var _node: Node3D = $"."
@onready var _animation_player: AnimationPlayer = %AnimationPlayer
@onready var _hurtbox: Area3D = %Hurtbox

@export var damage: float = 4

func get_attack_type() -> int:
	return PlayerAnimator.ATTACK_SLASH_VALUE

func play_attack():
	_animation_player.play("attack")
	return

func _ready() -> void:
	_hurtbox.body_entered.connect(_on_hurtbox_enterd)
	
func _on_hurtbox_enterd(body: Node3D) -> void:
	var parent = body.get_parent_node_3d()
	
	if("enemy" in parent.get_groups()):
		(parent as BaseEnemy).get_hit(damage, _node)
