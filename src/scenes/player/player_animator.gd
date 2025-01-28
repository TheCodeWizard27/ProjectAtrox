
class_name PlayerAnimator
extends AnimationTree

var _falling_blend_amount = "parameters/falling/blend_amount"
var _falling_blend_speed = 10
var _running_blend_position = "parameters/running/blend_position"
var _attack_animation = "attack_melee_1"
var _attack_request = "parameters/attack_one_shot/request"

signal on_attack_finished()

func advance_falling_to(target_value: float, delta: float) -> void:
	var new_value = lerpf(get(_falling_blend_amount), target_value, delta * _falling_blend_speed)
	set(_falling_blend_amount, new_value)
	
func reset_falling_animation() -> void:
	set(_falling_blend_amount, 0)

func set_running(speed: float) -> void:
	set(_running_blend_position, speed)

func play_attack() -> void:
	set(_attack_request, AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

func _on_animation_finished(anim_name: StringName) -> void:
	if(anim_name == _attack_animation):
		on_attack_finished.emit()
