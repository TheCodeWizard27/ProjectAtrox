extends CameraController

@export var enabled: bool = true:
	get:
		return enabled
	set(value):
		enabled = value
		_setup_camera()

var _speed: float = 20

func _ready() -> void:
	_setup_camera()

func _setup_camera() -> void:
	var remoteCamera = $'RemoteCamera';
	
	if(!enabled):
		remoteCamera.remote_path = ^''
		return
	
	if(camera != null):
		remoteCamera.remote_path = camera.get_path()

func _physics_process(delta: float) -> void:
	var move_dir = Vector3.ZERO
	
	move_dir.x = Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left')
	move_dir.z = Input.get_action_strength('ui_down') - Input.get_action_strength('ui_up')
	
	move_dir = transform.basis * move_dir
	
	move_dir.y += (Input.get_action_strength('jump') - Input.get_action_strength('shift'))
	
	move_dir = move_dir.normalized()
	
	position = lerp(position, position + move_dir * _speed, delta)

func _unhandled_input(event: InputEvent) -> void:
	if(not enabled):
		return
	
	super._unhandled_input(event)
	
	if(not camera.current):
		return
	
	if(event is InputEventMouseButton):
		match(event.button_index):
			MOUSE_BUTTON_WHEEL_UP:
				_speed = minf(_speed + 1, 100)
			MOUSE_BUTTON_WHEEL_DOWN:
				_speed = maxf(_speed - 1, 10)
