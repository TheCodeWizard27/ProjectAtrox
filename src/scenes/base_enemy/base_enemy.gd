class_name BaseEnemy
extends Node3D

@export var player: Player
@onready var _state: StateMachine = $'StateMachine'
@onready var _body: CharacterBody3D = $'CharacterBody3D'

var enemySpeed: float = 3.0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func chase(delta: float) -> void: 
	var direction = _body.global_position.direction_to(player._body.global_position)
	_body.velocity = direction * enemySpeed
	_body.velocity.y = -Globals.GRAVITY
	

	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	_state.physics_process(delta)
	_body.move_and_slide()
	#handle_collision()

#func handle_collision() -> void:
	#for i in _body.get_slide_collision_count():	
		##var collision = _body.get_slide_collision(i)
		##print("I collided with ", collision.get_collider().name)
