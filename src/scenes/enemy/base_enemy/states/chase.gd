
class_name EnemyChaseState
extends BaseEnemyState

var _attack_cooldown: float
var _detected_player: Player

func enter(msg: Dictionary = {}) -> void:
	_detected_player = msg[EnemyIdleState.PLAYER]
	enemy.player_detector.body_exited.connect(_on_body_exit)

func exit() -> void:
	enemy.player_detector.body_exited.disconnect(_on_body_exit)

func physics_update(delta: float) -> void:
	if(_detected_player == null):
		transition_to(BaseEnemyState.IDLE)
		return
	
	_attack_cooldown -= delta
	if(_attack_cooldown <= 0 && enemy.is_near_player(_detected_player)):
		_attack_cooldown = enemy.attack_cooldown
		transition_to(BaseEnemyState.ATTACK)
		return
	
	enemy.move_towards_player(_detected_player)

func _on_body_exit(body: Node3D) -> void:
	if(_detected_player == null || body == _detected_player.body):
		_detected_player = null
