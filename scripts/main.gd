extends Node3D

@onready var _floor = $Floor
@onready var server_container: ServerContiner = $Floor/ServerContainer

@onready var _server_scene: PackedScene = load("res://scenes/server.tscn")

@onready var time_label: Label = $CanvasLayer/Control/MarginContainer/VBoxContainer/HBoxContainer/TimeLabel

@onready var global_timer: Timer = $GlobalTimer

@onready var statistics_panel: StatisticsPanel = $CanvasLayer/StatisticsPanel

@onready var finance_manager: FinanceManager = $FinanceManager

var random_number_generator = RandomNumberGenerator.new()


var sessions: int
var computing_power_per_session: int = 10

var time_elapsed_in_second: int:
	set(time):
		time_elapsed_in_second = time
		time_label.text = str(time)



func _ready():
	var _grid_cell_scene: PackedScene = load("res://scenes/grid-cell.tscn")
	
	const Z = 0.015
	
	var origins = []
	
	for i in range(-2, 3):
		for j in range(-2, 3):
			origins.append(Vector3(0.7 * i, Z ,0.7 * j))
		

	var index: int = 0
	
	for origin in origins:
		var _grid_cell: Node3D = _grid_cell_scene.instantiate()
		_grid_cell.transform.origin = origin
		_grid_cell.index = index
		
		_grid_cell.clicked.connect(_on_grid_cell_clicked)
		
		_floor.add_child(_grid_cell)
		
		index+=1
		
		
	finance_manager.funds_added.connect(_on_funds_added)
	finance_manager.funds_removed.connect(_on_funds_removed)
	finance_manager.add_initial_funds(5000.0)
	
	global_timer.timeout.connect(_on_global_timer_tick)	
	global_timer.start()
	
		
		
func _on_global_timer_tick():
	time_elapsed_in_second += 1
	
	sessions = random_number_generator.randi_range(1, 100)
	statistics_panel.current_load = sessions * computing_power_per_session


func _on_funds_added(amount):
	statistics_panel.current_funds = finance_manager.current_funds
	
func _on_funds_removed(amount):
	statistics_panel.current_funds = finance_manager.current_funds

func _on_grid_cell_clicked(origin):
	var server: Server = _server_scene.instantiate()
	
	if not finance_manager.can_purchase(server.price):
		server.queue_free()
		return
	
	server_container.add_server(server)
	server.appear(origin)
	
	finance_manager.remove_funds(server.price)
	
	

	
	

func _on_server_container_computing_power_updated(computing_power) -> void:
	statistics_panel.total_computing_power = computing_power
