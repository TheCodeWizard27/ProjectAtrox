class_name BaseEnemy
extends Node3D

@export var player: Player
@onready var _state: StateMachine = $'StateMachine'
@onready var _body: CharacterBody3D = $'CharacterBody3D'

var enemySpeed: float = 3.0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func chase() -> void: 
	_body.velocity = (player._body.position - _body.position) * 3
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	_state.physics_process(delta)
