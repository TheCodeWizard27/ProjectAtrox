extends Control

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://src/scenes/level/map1.tscn")


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://src/scenes/menu/options/options_menu.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
