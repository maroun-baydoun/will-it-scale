extends Node
class_name DateTimeManager

@onready var timer: Timer = $GlobalTimer

signal ticked(date: Dictionary)

var time_elapsed_in_second: int = 0
var time_zone: Dictionary = Time.get_time_zone_from_system()
var current_unix_time: float = Time.get_unix_time_from_system() + (time_zone.bias * 60)
var start_unix_time: float = Time.get_unix_time_from_system() + (time_zone.bias * 60)


var current_date_time: Dictionary:
	set(date_time):
		current_date_time = date_time
		ticked.emit(current_date_time)

func start() -> void:
	var start_date_time = Time.get_datetime_dict_from_unix_time(start_unix_time)
	var seconds_since_start_of_day = start_date_time.hour * 3600 + start_date_time.minute * 60 + start_date_time.second
	start_unix_time -= seconds_since_start_of_day
	current_unix_time = start_unix_time
	timer.start()
	_set_current_date_time_from_unix_time()
	

func _set_current_date_time_from_unix_time():
	current_date_time = Time.get_datetime_dict_from_unix_time(current_unix_time)
	

func _on_timer_timeout() -> void:
	current_unix_time += 3600
	
	time_elapsed_in_second += 1
	
	_set_current_date_time_from_unix_time()
