extends PlayerState

func physics_update(delta: float) -> void:
	
	# TODO maybe always apply gravity instead of just in floating.
	#body.velocity.y -= Globals.GRAVITY * delta
	
	if(body.is_on_floor()):
		transition_to(PlayerState.GROUNDED)
		return
		
	player.process_movement(delta)
