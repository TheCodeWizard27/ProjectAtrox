class_name BaseEnemy
extends Node3D

@export var player: Player
@onready var _state: StateMachine = $'StateMachine'
@onready var _body: CharacterBody3D = $'CharacterBody3D'

signal on_hit(damage: int)

var enemy_speed: float = 3.0
var enemy_attack_damage: int = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	on_hit.connect(process_hit)
	pass # Replace with function body.

func process_hit(damage: int) -> void:
	print(damage)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	_state.physics_process(delta)
	_body.move_and_slide()

	for i in _body.get_slide_collision_count():	
		var collision = _body.get_slide_collision(i).get_collider()
		if(collision.is_in_group("player")):
			player.handle_hit(enemy_attack_damage)
