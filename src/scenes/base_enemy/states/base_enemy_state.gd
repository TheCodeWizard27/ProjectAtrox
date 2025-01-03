
class_name BaseEnemyState
extends State

@export var baseEnemy: BaseEnemy
@export var body: RigidBody3D

const IDLE: NodePath = ^'Idle'
const CHASE: NodePath = ^'Chase'
