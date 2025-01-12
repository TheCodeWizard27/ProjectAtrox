extends PlayerState

func physics_update(delta: float) -> void:
	
	#body.velocity.y -= Globals.GRAVITY * delta
	
	if(body.is_on_floor()):
		transition_to(PlayerState.GROUNDED)
		return
		
	player.process_movement(delta)
