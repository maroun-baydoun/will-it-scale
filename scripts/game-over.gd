extends PanelContainer

signal play_again_pressed


func _on_play_again_button_pressed() -> void:
	play_again_pressed.emit()
