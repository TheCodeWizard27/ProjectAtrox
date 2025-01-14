extends PlayerState

func exit() -> void:
	pass
	#player.set_walking_animation(0)

func update(delta: float) -> void:
	pass
	#player.process_movement_animation()

func physics_update(delta: float) -> void:
	
	if(!body.is_on_floor()):
		transition_to(PlayerState.AIRBORNE)
		return
	
	if(Input.is_action_just_pressed("jump")):
		transition_to(PlayerState.JUMPING)
		return
	
	player.process_movement(delta)
	
