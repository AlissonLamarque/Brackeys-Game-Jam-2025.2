extends Node

@export var main_menu_scene : PackedScene

var current_scene: Node

func _ready():
	change_scene(main_menu_scene)

func change_scene(scene_to_load: PackedScene):
	# Remove the current scene if it exists
	if is_instance_valid(current_scene):
		current_scene.queue_free()
	# New instance of the scene that's about to be loaded
	current_scene = scene_to_load.instantiate()
	# Connect the universal singal signal of the new scene to this function
	if current_scene.has_signal("change_scene_requested"):
		# Any scene can change to the desired scene
		current_scene.change_scene_requested.connect(change_scene)
	# Add the new scene as a child node of Main
	add_child(current_scene)

# Determining that Esc closes the game for developing
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
