extends Control
class_name Toolbar

signal zoomed_out
signal zoomed_in

@onready var zoom_out_button: Button = %ZoomOutButton
@onready var zoom_in_button: Button = %ZoomInButton

func disable_zoom_out_button() -> void:
	zoom_out_button.disabled = true
	
func enable_zoom_out_button() -> void:
	zoom_out_button.disabled = false
	
func disable_zoom_in_button() -> void:
	zoom_in_button.disabled = true
	
func enable_zoom_in_button() -> void:
	zoom_in_button.disabled = false

func _on_zoom_out_button_pressed() -> void:
	zoomed_out.emit()


func _on_zoom_in_button_pressed() -> void:
	zoomed_in.emit()
