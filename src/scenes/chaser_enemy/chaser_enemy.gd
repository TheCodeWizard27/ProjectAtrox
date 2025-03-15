class_name ChaserEnemy
extends BaseEnemy

func chase(delta: float) -> void: 
	var direction = _body.global_position.direction_to(player._body.global_position)
	_body.velocity = direction * enemy_speed
	_body.velocity.y = -Globals.GRAVITY
	pass
