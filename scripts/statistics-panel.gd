extends Control
class_name StatisticsPanel

@onready var current_funds_label:Label =  %CurrentFundsLabel
@onready var total_computing_power_label:Label =  %TotalComputingPowerLabel
@onready var current_load_label: Label = %CurrentLoadLabel
@onready var average_response_time_label: Label = %AverageResponseTimeLabel
@onready var current_power_consumption_label: Label = %CurrentPowerConsumptionLabel

@onready var panels = get_tree().get_nodes_in_group("statistics-panel")
@onready var tooltip: PanelContainer = %Tooltip
@onready var tooltip_label: Label = %TooltipLabel

const TOOLTIP_CONTENT: Dictionary = {
	"funds": "Funds allow you to purchase new servers. Every session generates a small amount of revenue. The lower the server load, the more revenue is generated.",
	"computing-power": "The computing power is the total load that the servers can currently handle. Purchasing servers increases this value.",
	"load": "The load increases as more users try to access the website. Once the load reaches 95% of the current computing power, the response time starts to increase. Purchasing more servers lowers the load temporarily until more users try to access the website.",
	"response-time": "A response time higher than 300 ms degrades the user experience and raises their frustration. Lowering the load decreases this value.",
	"power-consumption": "Every server consumes power. The higher the power consumption, the more funds are used to pay the daily power bill."
}

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
	tooltip.hide()
		
	for panel in panels:
		panel.mouse_entered.connect(func (): _on_panel_container_mouse_entered(panel))
		panel.mouse_exited.connect(_on_panel_container_mouse_exited)

func _on_panel_container_mouse_entered(panel: PanelContainer) -> void:
	var statistic: String = panel.get_meta("statistic")
	tooltip_label.text = TOOLTIP_CONTENT[statistic]
	tooltip.set_position(Vector2(panel.global_position.x + panel.size.x + 16, panel.global_position.y))
	tooltip_label.show()
	tooltip.show()
	


func _on_panel_container_mouse_exited() -> void:
	tooltip_label.hide()
	tooltip.hide()
	
