extends Node3D

const MAX_CAMERA_SIZE: int = 10

@onready var camera = $Camera3D

func _unhandled_input(event):
	if event.is_action_pressed("zoom_in"):
		camera.size -=1
		
	elif event.is_action_pressed("zoom_out"):
		if (camera.size < MAX_CAMERA_SIZE):
			camera.size +=1
		
				

	if event is InputEventMouseMotion:
		if event.button_mask == MOUSE_BUTTON_MASK_MIDDLE:
			rotate(Vector3(0, 1,0),event.relative.x * -0.002)

