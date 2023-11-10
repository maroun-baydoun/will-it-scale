extends Node3D

@onready var _camera = $CameraContainer/Camera3D
@onready var _camera_container = $CameraContainer
@onready var _floor = $Floor

@onready var _server_scene: PackedScene = load("res://scenes/server.tscn")


const MAX_CAMERA_SIZE: int = 10

func _ready():
	var _grid_cell_scene: PackedScene = load("res://scenes/grid-cell.tscn")
	
	const Z = 0.015
	
	var transforms = []
	
	
	
	for i in range(-2, 3):
		for j in range(-2, 3):
			transforms.append(Vector3(0.7 * i, Z ,0.7 * j))
		

	var index: int = 0
	
	for transform in transforms:
		var _grid_cell: Node3D = _grid_cell_scene.instantiate()
		_grid_cell.transform.origin = transform
		_grid_cell.index = index
		
		_grid_cell.clicked.connect(_on_click)
		
		_floor.add_child(_grid_cell)
		
		index+=1
		

func _on_click(origin):
	var server = _server_scene.instantiate()
	var server_height = server.mesh.size.y
	server.transform.origin = origin
	server.transform.origin.y = -server_height * 5
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.tween_property(server, "transform:origin:y", server_height  / 2, 0.5)
	
	_floor.add_child(server)
	
	
func _unhandled_input(event):
	if event.is_action_pressed("zoom_in"):
		_camera.size -=1
		
	elif event.is_action_pressed("zoom_out"):
		if (_camera.size < MAX_CAMERA_SIZE):
			_camera.size +=1
		
				

	if event is InputEventMouseMotion:
		if event.button_mask == MOUSE_BUTTON_MASK_MIDDLE:
			_camera_container.rotate(Vector3(0, 1,0),event.relative.x * -0.002)
	
	





	
