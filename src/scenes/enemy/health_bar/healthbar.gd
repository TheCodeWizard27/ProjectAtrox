class_name HealthBar
extends Control

@onready var progress_bar: ProgressBar = $ProgressBar

func setup(max_health: float) -> void:
	progress_bar.max_value = max_health
	progress_bar.value = max_health

func update(current_health: float) -> void:
	progress_bar.value = current_health
