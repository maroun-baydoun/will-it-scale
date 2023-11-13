extends MeshInstance3D
class_name GridCell

var index: int;
var is_empty: bool = true;

signal clicked(origin);

@onready var _initial_alpha = mesh.material.albedo_color.a


func occupy():
	is_empty = false
	mesh.material.albedo_color.a = 0.0

func _on_body_input_event(camera, event, position, normal, shape_idx):
	if (event is InputEventMouseButton):
		if event.button_mask == MOUSE_BUTTON_MASK_LEFT and event.pressed:
			if is_empty:
				clicked.emit(self)
				

func _on_body_mouse_entered():
	if is_empty:
		mesh.material.albedo_color.a = _initial_alpha + 0.4


func _on_body_mouse_exited():
	if is_empty:
		mesh.material.albedo_color.a = _initial_alpha
