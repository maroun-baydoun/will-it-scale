extends Node

func _ready() -> void:
	var args = OS.get_cmdline_user_args()

	if args.has('--skip-title'):
		_change_to_main_scene()

func _on_start_button_pressed() -> void:
	_change_to_main_scene()

func _change_to_main_scene() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	
