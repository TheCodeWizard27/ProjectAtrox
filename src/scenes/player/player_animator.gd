
class_name PlayerAnimator
extends AnimationTree

var _falling_blend_amount = "parameters/falling/blend_amount"
var _falling_blend_speed = 10
var _running_blend_position = "parameters/running/blend_position"

func advance_falling_to(target_value: float, delta: float) -> void:
	var new_value = lerpf(get(_falling_blend_amount), target_value, delta * _falling_blend_speed)
	set(_falling_blend_amount, new_value)


func set_running(speed: float) -> void:
	set(_running_blend_position, speed)
