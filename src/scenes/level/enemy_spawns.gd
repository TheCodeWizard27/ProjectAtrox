extends Node

func _ready() -> void:
	var enemy_scene = preload("res://src/scenes/enemy/enemy_melee/enemy_melee.tscn")
	var children = get_children()
	
	for child in children:
		var new_enemy = enemy_scene.instantiate()
		add_child(new_enemy)
		new_enemy.global_position = (child as Node3D).global_position
