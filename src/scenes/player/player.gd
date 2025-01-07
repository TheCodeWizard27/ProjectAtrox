
class_name Player
extends Node3D

@export var enabled: bool = true:
	get:
		return enabled
	set(value):
		enabled = value
		_setup_camera()
@export var speed: float = Globals.PLAYER_SPEED
@export var jump_height: float = Globals.PLAYER_JUMP_HEIGHT
@export var jump_time: float = Globals.PLAYER_JUMP_TIME
@export var turn_threshold: float = 0.2

@export var camera: Camera3D

@onready var _state: StateMachine = $'State'
@onready var _body: CharacterBody3D = $'Body'
@onready var _camera_mount: CameraController = $'CameraMount'

func process_movement(delta: float, speed_modifier: float = 1):
	var move_dir = Vector3.ZERO
	move_dir.x = Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left')
	move_dir.z = Input.get_action_strength('ui_down') - Input.get_action_strength('ui_up')
	move_dir = move_dir.rotated(Vector3.UP, _camera_mount.rotation.y).normalized()
	
	var x_speed = move_dir.x * speed * speed_modifier
	var z_speed = move_dir.z * speed * speed_modifier
	
	_body.velocity.x = lerpf(_body.velocity.x, min(x_speed, speed), 1)
	_body.velocity.z = lerpf(_body.velocity.z, min(z_speed, speed), 1)

func _ready() -> void:
	_setup_camera()

func _setup_camera() -> void:
	var remoteCamera = $CameraMount/CameraArm/RemoteCamera;
	
	if(!enabled):
		remoteCamera.remote_path = ^''
		return
	
	if(camera != null):
		remoteCamera.remote_path = camera.get_path()
		_camera_mount.camera = camera

func _process(delta: float) -> void:
	if(!enabled):
		return
	
	_state.process(delta)
	
func _physics_process(delta: float) -> void:
	if(!enabled):
		return
	
	_state.physics_process(delta)
	_apply_movement(delta)

func _apply_movement(delta: float) -> void:
	_body.move_and_slide()
	
	var movement = Vector2(_body.velocity.x, _body.velocity.z)
	
	if(movement.length() > turn_threshold):
		var target = Quaternion(Vector3.UP, Vector2(_body.velocity.z, _body.velocity.x).angle())
		_body.basis = _body.basis.slerp(target, 0.2)
