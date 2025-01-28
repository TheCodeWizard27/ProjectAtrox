extends PlayerState

@export var cancel_time: float = 0.8
@export var lag_time: float = 1.2

var _attack_animation_finished: bool = false
var _attack_time: float

func enter(msg: Dictionary = {}) -> void:
	_attack_animation_finished = false
	animator.on_attack_finished.connect(_on_attack_finished)
	animator.play_attack()
	animator.reset_falling_animation()

func physics_update(delta: float) -> void:
	player.process_movement(delta, 0)
	
	if(_attack_animation_finished):
		#_attack_time += delta
		transition_to(PlayerState.GROUNDED)

func exit() -> void:
	animator.on_attack_finished.disconnect(_on_attack_finished)

func _on_attack_finished() -> void:
	_attack_animation_finished = true
