extends Node3D
class_name CameraController

const MAX_CAMERA_SIZE: int = 10
const MIN_CAMERA_SIZE: int = 2

@onready var camera = $Camera3D

func zoom_in() -> void:
	if can_zoom_in():
		#camera.size -=1
		get_tree().create_tween().tween_property(camera, "size", camera.size - 1, 0.2)
	
func zoom_out() -> void:
	if can_zoom_out():
		get_tree().create_tween().tween_property(camera, "size", camera.size + 1, 0.2)
	
func can_zoom_out() -> bool:
	return camera.size < MAX_CAMERA_SIZE
	
func can_zoom_in() -> bool:
	return camera.size > MIN_CAMERA_SIZE

func _unhandled_input(event):
	if event.is_action_pressed("zoom_in"):
		zoom_in()
		
	elif event.is_action_pressed("zoom_out"):
		zoom_out()
		
	if event is InputEventMouseMotion:
		if event.button_mask == MOUSE_BUTTON_MASK_MIDDLE:
			rotate(Vector3(0, 1,0),event.relative.x * -0.002)

