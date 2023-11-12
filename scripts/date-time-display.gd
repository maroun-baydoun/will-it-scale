extends Control
class_name DateTimeDisplay

@onready var label: Label = $MarginContainer/Label

const DATE_TIME_FORMAT = "%s/%s/%s"

var current_date_time: Dictionary:
	set(date_time):
		current_date_time = date_time
		label.text = DATE_TIME_FORMAT % [date_time.day, date_time.month, date_time.year]
