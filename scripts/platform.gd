extends Node3D
class_name Platform

signal on_grid_cell_clicked(cell: GridCell)

@onready var server_container: Node3D = %ServerContainer
@onready var platform_mesh: MeshInstance3D = %PlatformMesh

var grid_cells: Array[GridCell] = []

func _ready() -> void:
	_add_grid_cells()
	
	
func set_grid_cells_can_receive_input(can_receive_input: bool) -> void:
	for grid_cell in grid_cells:
		grid_cell.can_receive_input = can_receive_input


func add_server(server: Server) -> void:
	server_container.add_child(server)

func _add_grid_cells() -> void:
	var origins = []
	
	for i in range(-2, 3):
		for j in range(-2, 3):
			origins.append(Vector3(0.65 * i, 1.0001 ,0.65 * j))
		
	var grid_cell_scene: PackedScene = load("res://scenes/grid-cell.tscn")
	
	for origin in origins:
		var grid_cell: GridCell = grid_cell_scene.instantiate()
		grid_cell.transform.origin = origin
		
		grid_cell.clicked.connect(_on_grid_cell_clicked)
		
		platform_mesh.add_child(grid_cell)
		grid_cells.append(grid_cell)
		
func _on_grid_cell_clicked(cell: GridCell):
	on_grid_cell_clicked.emit(cell)
	
