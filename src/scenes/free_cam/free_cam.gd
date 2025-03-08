extends CameraController

@export var max_speed: float = 100
@export var min_speed: float = 10
@export var speed_increment: float = 1

@onready var _camera: Camera3D = $Camera3D

var _speed: float = 20

func _ready() -> void:
	active_changed.connect(func(value): _camera.current = value)

func _physics_process(delta: float) -> void:
	if(not active):
		return
	
	var move_dir = Vector3.ZERO
	
	move_dir.x = Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left')
	move_dir.z = Input.get_action_strength('ui_down') - Input.get_action_strength('ui_up')
	
	move_dir = transform.basis * move_dir
	
	move_dir.y += (Input.get_action_strength('jump') - Input.get_action_strength('shift'))
	
	move_dir = move_dir.normalized()
	
	position = lerp(position, position + move_dir * _speed, delta)

func _input(event: InputEvent) -> void:
	if(not active):
		return
	
	super._input(event)
	
	if(event is InputEventMouseButton):
		match(event.button_index):
			MOUSE_BUTTON_WHEEL_UP:
				_speed = minf(_speed + speed_increment, max_speed)
			MOUSE_BUTTON_WHEEL_DOWN:
				_speed = maxf(_speed - speed_increment, min_speed)
