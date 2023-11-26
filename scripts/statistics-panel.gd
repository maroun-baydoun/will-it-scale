extends Control
class_name StatisticsPanel

@onready var current_funds_label:Label =  %CurrentFundsLabel
@onready var total_computing_power_label:Label =  %TotalComputingPowerLabel
@onready var current_load_label: Label = %CurrentLoadLabel
@onready var average_response_time_label: Label = %AverageResponseTimeLabel
@onready var current_power_consumption_label: Label = %CurrentPowerConsumptionLabel

@onready var panels = get_tree().get_nodes_in_group("statistics-panel")
@onready var tooltip: PanelContainer = %Tooltip

var current_funds: float:
	set(value):
		current_funds_label.text = str(value)

var total_computing_power: int:
	set(value):
		total_computing_power_label.text = str(value)

var current_load: int:
	set(value):
		current_load_label.text = str(value)
		
var average_response_time: int:
	set(value):
		average_response_time_label.text = "%sms" % value
		
var current_power_consumption:int:
	set(value):
		current_power_consumption_label.text = "%skWh" % value
		
func _ready():
	tooltip.visible = false
		
	for panel in panels:
		panel.mouse_entered.connect(func (): _on_panel_container_mouse_entered(panel))
		panel.mouse_exited.connect(_on_panel_container_mouse_exited)

func _on_panel_container_mouse_entered(panel: PanelContainer) -> void:
	tooltip.position.x = panel.global_position.x + panel.size.x + 16
	tooltip.position.y = panel.global_position.y + panel.size.y / 2 - tooltip.size.y / 2
	# tooltip.visible = true


func _on_panel_container_mouse_exited() -> void:
	tooltip.visible = false
