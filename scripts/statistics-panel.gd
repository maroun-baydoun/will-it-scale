extends Control
class_name StatisticsPanel

@onready var current_funds_label:Label =  %CurrentFundsLabel
@onready var total_computing_power_label:Label =  %TotalComputingPowerLabel
@onready var current_load_label: Label = %CurrentLoadLabel
@onready var average_response_time_label: Label = %AverageResponseTimeLabel
@onready var current_power_consumption_label: Label = %CurrentPowerConsumptionLabel


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
		current_power_consumption_label.text = str(value)
		
