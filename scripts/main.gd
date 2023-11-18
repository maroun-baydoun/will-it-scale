extends Node3D

@onready var camera_controller: CameraController = $CameraController
@onready var server_container: ServerContiner = %ServerContainer
@onready var platform_mesh : MeshInstance3D = %PlatformMesh
@onready var server_scene: PackedScene = load("res://scenes/server.tscn")
@onready var grid_cell_scene: PackedScene = load("res://scenes/grid-cell.tscn")

@onready var date_time_manager: DateTimeManager = $DateTimeManager 
@onready var statistics_panel: StatisticsPanel = %StatisticsPanel
@onready var toolbar: Toolbar = %Toolbar
@onready var date_time_display: DateTimeDisplay = %DateTimeDisplay
@onready var finance_manager: FinanceManager = $FinanceManager
@onready var traffic_manager := $TrafficManager
@onready var power_manager := $PowerManager

var sessions: int
var computing_power_per_session: int = 10


func _ready():
	const Y := 1.0001
	
	var origins = []
	
	for i in range(-2, 3):
		for j in range(-2, 3):
			origins.append(Vector3(0.65 * i, Y ,0.65 * j))
		

	var index: int = 0
	
	for origin in origins:
		var grid_cell: Node3D = grid_cell_scene.instantiate()
		grid_cell.transform.origin = origin
		grid_cell.index = index
		
		grid_cell.clicked.connect(_on_grid_cell_clicked)
		
		platform_mesh.add_child(grid_cell)
		
		index+=1
		
		
	finance_manager.funds_added.connect(_on_funds_added)
	finance_manager.funds_removed.connect(_on_funds_removed)
	finance_manager.add_initial_funds(5000.0)
	
	date_time_manager.start()
	
	
		
func _on_funds_added(amount):
	statistics_panel.current_funds = finance_manager.current_funds
	
func _on_funds_removed(amount):
	statistics_panel.current_funds = finance_manager.current_funds

func _on_grid_cell_clicked(cell: GridCell):
	var server: Server = server_scene.instantiate()
	
	if not finance_manager.can_purchase(server.price):
		server.queue_free()
		return
	
	cell.occupy()
	server_container.add_server(server)
	server.appear(cell.transform.origin)
	
	finance_manager.remove_funds(server.price)
	power_manager.increase_hourly_power_consumption(server.hourly_power_consumption)
	
func _on_server_container_computing_power_updated(computing_power) -> void:
	statistics_panel.total_computing_power = computing_power


func _on_power_manager_hourly_power_consumption_decreased(amount: int) -> void:
	statistics_panel.current_power_consumption = power_manager.current_hourly_power_consumption


func _on_power_manager_hourly_power_consumption_increased(amount: int) -> void:
	statistics_panel.current_power_consumption = power_manager.current_hourly_power_consumption


func _on_time_advanced(hour, day) -> void:
	date_time_display.current_hour = hour
	date_time_display.current_day = day
	
	traffic_manager.generate_traffic()
	statistics_panel.current_load = traffic_manager.current_load


func _on_toolbar_zoomed_in() -> void:
	if camera_controller.can_zoom_in():
		camera_controller.zoom_in()
		toolbar.enable_zoom_out_button()
	else:
		toolbar.disable_zoom_in_button()


func _on_toolbar_zoomed_out() -> void:
	if camera_controller.can_zoom_out():
		camera_controller.zoom_out()
		toolbar.enable_zoom_in_button()
	else:
		toolbar.disable_zoom_out_button()
