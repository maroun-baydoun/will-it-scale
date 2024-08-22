extends Node3D
class_name CameraController

signal zoomed_in
signal zoomed_out
signal max_zoom_out_reached
signal max_zoom_in_reached

const MAX_CAMERA_SIZE: int = 10
const MIN_CAMERA_SIZE: int = 2
const DEFAULT_CAMERA_SIZE : int = 6

@onready var camera = $Camera3D

func zoom_in() -> void:
	if can_zoom_in():
		var tween = get_tree().create_tween()
		tween.tween_property(camera, "size", camera.size - 1, 0.1)
		tween.tween_callback(func (): 
			if !can_zoom_in():
				max_zoom_in_reached.emit()
			else:
				zoomed_in.emit()
		)

func zoom_out() -> void:
	if can_zoom_out():
		var tween = get_tree().create_tween()
		tween.tween_property(camera, "size", camera.size + 1, 0.1)
		tween.tween_callback(func (): 
			if !can_zoom_out():
				max_zoom_out_reached.emit()
			else:
				zoomed_out.emit()
		)

func can_zoom_out() -> bool:
	return camera.size < MAX_CAMERA_SIZE
	
func can_zoom_in() -> bool:
	return camera.size > MIN_CAMERA_SIZE
	
func rotate_left() -> void:
	get_tree().create_tween().tween_property(self, "rotation_degrees:y", rotation_degrees.y - 45, 0.2)
	
func rotate_right() -> void:
	get_tree().create_tween().tween_property(self, "rotation_degrees:y", rotation_degrees.y + 45, 0.2)
	
func enter() -> Signal :
	var tween := get_tree().create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property(camera, "size", DEFAULT_CAMERA_SIZE, 1)
	
	return tween.finished

func _unhandled_input(event):
	if event.is_action_pressed("zoom_in"):
		zoom_in()
		
	elif event.is_action_pressed("zoom_out"):
		zoom_out()
		
	if event is InputEventMouseMotion:
		if event.button_mask == MOUSE_BUTTON_MASK_MIDDLE:
			rotate(Vector3(0,1,0),event.relative.x * -0.002)
