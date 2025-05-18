extends MeshInstance3D
class_name GridCell

const UNASSIGNED_SERVER_ID: int = -1;

var is_empty: bool = true;
var server_id: int = UNASSIGNED_SERVER_ID;

signal clicked(origin);

@onready var _initial_alpha = mesh.material.albedo_color.a

var can_receive_input : bool = false

func occupy(s_id: int):
	server_id = s_id
	is_empty = false
	mesh.material.albedo_color.a = 0.0
	
func liberate():
	is_empty = true
	server_id = UNASSIGNED_SERVER_ID
	mesh.material.albedo_color.a = _initial_alpha

func _on_body_input_event(camera, event, position, normal, shape_idx):
	if (event is InputEventMouseButton):
		if event.button_mask == MOUSE_BUTTON_MASK_LEFT and event.pressed:
			if is_empty and can_receive_input:
				clicked.emit(self)
				

func _on_body_mouse_entered():
	if is_empty and can_receive_input:
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
		mesh.material.albedo_color.a = _initial_alpha + 0.4


func _on_body_mouse_exited():
	if is_empty and can_receive_input:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
		mesh.material.albedo_color.a = _initial_alpha
