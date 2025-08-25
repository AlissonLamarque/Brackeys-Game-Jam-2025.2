extends Control

signal change_scene_requested(scene_to_load: PackedScene)

@onready var timer: Timer = $Timer

@export var game_scene: PackedScene

func _on_start_pressed() -> void:
	change_scene_requested.emit(game_scene)

func _on_credits_pressed() -> void:
	pass # Replace with function body.

func _on_quit_pressed() -> void:
	timer.start()

func _on_timer_timeout() -> void:
	get_tree().quit()
