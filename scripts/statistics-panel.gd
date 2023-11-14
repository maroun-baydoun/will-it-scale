extends Control
class_name StatisticsPanel

@onready var current_funds_label:Label =  %CurrentFundsLabel
@onready var total_computing_power_label:Label =  %TotalComputingPowerLabel
@onready var current_load_label: Label = %CurrentLoadLabel


var current_funds:float:
	set(value):
		current_funds_label.text = str(value)

var total_computing_power:int:
	set(value):
		total_computing_power_label.text = str(value)


var current_load:int:
	set(value):
		current_load_label.text = str(value)
		
