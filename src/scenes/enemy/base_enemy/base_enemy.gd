extends Node3D
class_name BaseEnemy

@export var turn_threshold: float = Globals.ENTITY_TURN_THRESHOLD
@export var attack_distance: float = 2
@export var attack_cooldown: float = 4
@export var attack_time: float = 1
@export var attack_damage: float = 2
@export var max_health: float = 5
@export var speed: float = 5.0

@export var state: StateMachine
@export var body: CharacterBody3D
@export var player_detector: Area3D

var current_health: float = max_health

func move_towards_player(target: Player) -> void:
	if(is_near_player(target)):
		return
	
	var direction = body.global_position.direction_to(target.body.global_position)
	direction.y = 0
	body.velocity = direction * speed
	
func is_near_player(target: Player) -> bool:
	var distance = body.global_position.distance_to(target.body.global_position)
	return distance <= attack_distance

func get_hit(damage: float, source: Node3D) -> void:
	current_health = max(current_health - damage, 0)

func attack() -> void:
	pass

func _process(delta: float) -> void:
	state.process(delta)
	
func _physics_process(delta: float) -> void:
	var y_velocity = body.velocity.y
	body.velocity = Vector3() # reset previous movement

	state.physics_process(delta)
	
	body.velocity.y = y_velocity - Globals.GRAVITY * delta
	body.move_and_slide()
	
	var movement = Vector2(body.velocity.x, body.velocity.z)
	
	if(movement.length() > turn_threshold):
		var target = Quaternion(Vector3.UP, Vector2(body.velocity.z, body.velocity.x).angle())
		body.basis = body.basis.slerp(target, 0.2)
