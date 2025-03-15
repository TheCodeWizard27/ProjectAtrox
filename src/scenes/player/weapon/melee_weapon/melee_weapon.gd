extends Weapon

@onready var _animation_player: AnimationPlayer = %AnimationPlayer

func get_attack_type() -> int:
	return PlayerAnimator.ATTACK_SLASH_VALUE

func play_attack():
	_animation_player.play("attack")
	return 

func _on_area_3d_body_entered(body: Node3D) -> void:
	if(body.is_in_group("enemy")):
		var enemy = body.get_parent() as BaseEnemy
		enemy.on_hit.emit(5)
