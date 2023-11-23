extends Node
class_name DateTimeManager

@onready var timer: Timer = $GlobalTimer

signal time_advanced(hour: int, day: int)

var time_elapsed_in_second: int = 0


var current_hour: int = 0
var current_day :int = 1


func start() -> void:
	time_advanced.emit(current_hour, current_day)
	timer.start()
	
func stop() -> void:
	timer.stop()

func _on_timer_timeout() -> void:
	time_elapsed_in_second += 1
	
	time_advanced.emit(current_hour, current_day)
	
	current_hour += 1
	
	if current_hour == 24:
		current_hour = 0
		current_day +=1
		
	
	
	
