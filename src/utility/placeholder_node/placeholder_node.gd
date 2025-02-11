extends Node

class_name PlaceholderNode

var _current_node: Node

func create_new(new_scene: PackedScene) -> Node:
	if(_current_node != null):
		var test = get_parent().get_children()
		get_parent().remove_child(_current_node)
		_current_node.queue_free()
	
	_current_node = new_scene.instantiate()
	add_sibling(_current_node)
	return _current_node
