extends Node3D

@onready var camera_controller: CameraController = $CameraController
@onready var server_container: ServerContiner = %ServerContainer
@onready var platform_mesh : MeshInstance3D = %PlatformMesh
@onready var date_time_manager: DateTimeManager = $DateTimeManager 
@onready var statistics_panel: StatisticsPanel = %StatisticsPanel
@onready var toolbar: Toolbar = %Toolbar
@onready var date_time_display: DateTimeDisplay = %DateTimeDisplay
@onready var progress_bars: ProgressBars = %ProgressBars
@onready var finance_manager: FinanceManager = $FinanceManager
@onready var traffic_manager := $TrafficManager
@onready var power_manager := $PowerManager
@onready var user_frustration_manager := $UserFrustrationManager
@onready var gui_layer: CanvasLayer = $GuiLayer


@onready var server_scene: PackedScene = load("res://scenes/server.tscn")
@onready var grid_cell_scene: PackedScene = load("res://scenes/grid-cell.tscn")
@onready var game_over_scene: PackedScene = load("res://gui/game-over.tscn")


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
	user_frustration_manager.start()
	
	
func _play_again() -> void:
	get_tree().reload_current_scene()
	Engine.time_scale = 1.0
	
func _display_game_over_screen() -> Signal:
	var game_over_instance := game_over_scene.instantiate()
	game_over_instance.modulate.a = 0
	gui_layer.add_child(game_over_instance)
	game_over_instance.play_again_pressed.connect(func(): _play_again())
	return get_tree().create_tween().tween_property(game_over_instance, "modulate:a", 1.0, 2).finished
		
func _game_over() -> void:
	date_time_manager.stop()
	user_frustration_manager.stop()
	await _display_game_over_screen()
	Engine.time_scale = 0.0
	
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


func _on_time_advanced(hour:int, day:int) -> void:
	date_time_display.current_hour = hour
	date_time_display.current_day = day
	
	traffic_manager.generate_traffic(server_container.total_computing_power, date_time_manager.current_day)
	statistics_panel.current_load = traffic_manager.current_load
	user_frustration_manager.current_load_ratio = traffic_manager.current_load_ratio

func _on_toolbar_zoomed_in() -> void:
	camera_controller.zoom_in()

func _on_toolbar_zoomed_out() -> void:
	camera_controller.zoom_out()

func _on_camera_controller_zoomed_in() -> void:
	toolbar.enable_zoom_out_button()
	
func _on_camera_controller_zoomed_out() -> void:
	toolbar.enable_zoom_in_button()
	
func _on_camera_controller_max_zoom_out_reached() -> void:
	toolbar.disable_zoom_out_button()

func _on_camera_controller_max_zoom_in_reached() -> void:
	toolbar.disable_zoom_in_button()

func _on_toolbar_rotated_left() -> void:
	camera_controller.rotate_left()

func _on_toolbar_rotated_right() -> void:
	camera_controller.rotate_right()

func _on_user_user_frustration_increased(amount: float) -> void:
	progress_bars.user_frustration = user_frustration_manager.user_frustration

func _on_user_frustration_decreased(amount: float) -> void:
	progress_bars.user_frustration = user_frustration_manager.user_frustration

func _on_user_frustration_max_reached() -> void:
	_game_over()
