extends Control
class_name StatisticsPanel

@onready var total_computing_power_label:Label =  $MarginContainer/VBoxContainer/VBoxContainer/TotalComputingPowerLabel
@onready var current_load_label: Label = $MarginContainer/VBoxContainer/VBoxContainer2/CurrentLoadLabel

var total_computing_power:int:
	set(value):
		total_computing_power_label.text = str(value)


var current_load:int:
	set(value):
		current_load_label.text = str(value)
		
