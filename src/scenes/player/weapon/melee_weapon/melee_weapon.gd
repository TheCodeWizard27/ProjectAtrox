extends Weapon

@onready var _animation_player: AnimationPlayer = %AnimationPlayer

func get_attack_type() -> int:
	return PlayerAnimator.ATTACK_SLASH_VALUE

func play_attack():
	_animation_player.play("attack")
	return 
