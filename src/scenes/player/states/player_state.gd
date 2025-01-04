
class_name PlayerState
extends State

@export var player: Player
@export var body: CharacterBody3D

const AIRBORNE: NodePath = ^'Airborne'
const GROUNDED: NodePath = ^'Grounded'
