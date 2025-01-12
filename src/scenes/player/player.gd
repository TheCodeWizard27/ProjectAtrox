
class_name Player
extends Node3D

@export var active: bool = true:
	get:
		return active
	set(value):
		active = value
		Utils.call_when_ready(self, func(): _set_camera_active(value))
		
@export var max_speed: float = Globals.PLAYER_MAX_SPEED
@export var acceleration: float = Globals.PLAYER_ACCELERATION # Why does only a value of like 100 feel good.
@export var min_jump_height: float = Globals.PLAYER_MIN_JUMP_HEIGHT
@export var max_jump_height: float = Globals.PLAYER_MAX_JUMP_HEIGHT
@export var jump_time: float = Globals.PLAYER_JUMP_TIME
@export var turn_threshold: float = Globals.PLAYER_TURN_THRESHOLD

@onready var _state: StateMachine = $'State'
@onready var _body: CharacterBody3D = $'Body'
@onready var _camera_mount: CameraController = $'CameraMount'

func process_movement(delta: float, speed_modifier: float = 1):
	var move_dir = Vector3.ZERO
	move_dir.x = Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left')
	move_dir.z = Input.get_action_strength('ui_down') - Input.get_action_strength('ui_up')
	move_dir = move_dir.rotated(Vector3.UP, _camera_mount.rotation.y).normalized()
	
	# Calculate velocity with separated y component.
	var y_velocity = _body.velocity.y
	_body.velocity = _body.velocity.move_toward(move_dir * max_speed, acceleration * delta)
	_body.velocity.y = y_velocity - Globals.GRAVITY * 3 * delta
	
	# Rotate Character body	
	if(move_dir.length() > turn_threshold):
		var target = Vector3.BACK.signed_angle_to(move_dir, Vector3.UP)
		_body.rotation.y = lerp_angle(_body.rotation.y, target, 10 * delta)
	
	#var x_speed = move_dir.x * speed * speed_modifier
	#var z_speed = move_dir.z * speed * speed_modifier
	
	#_body.velocity.x = lerpf(_body.velocity.x, min(x_speed, speed), 1)
	#_body.velocity.z = lerpf(_body.velocity.z, min(z_speed, speed), 1)

func _set_camera_active(value: bool) -> void:
	_camera_mount.active = value

func _process(delta: float) -> void:
	if(!active):
		return
	
	_state.process(delta)
	
func _physics_process(delta: float) -> void:
	if(!active):
		return
	
	_state.physics_process(delta)
	_apply_movement(delta)

func _apply_movement(delta: float) -> void:
	_body.move_and_slide()
