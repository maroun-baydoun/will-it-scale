extends Node
class_name ResponseTimeManager

signal average_response_time_increased(amount: float)
signal average_response_time_decreased(amount: float)

@onready var timer : Timer = $Timer

enum AVERAGE_RESPONSE_TIME_GROWTH_DIRECTION {INCREASE, DECREASE}

const MINUMUM_AVERAGE_RESPONSE_TIME := 200 #ms
const INITIAL_AVERAGE_RESPONSE_TIME := 300 #ms
const AVERAGE_RESPONSE_TIME_DELTA := 10 #ms
const CURRENT_LOAD_RATIO_THRESHOLD = 0.95

var average_response_time := INITIAL_AVERAGE_RESPONSE_TIME
var average_response_time_difference_from_initial := 0
var average_response_time_growth_direction : AVERAGE_RESPONSE_TIME_GROWTH_DIRECTION


var current_load_ratio := 0.0 :
	set(ratio):
		current_load_ratio = ratio
		if current_load_ratio > CURRENT_LOAD_RATIO_THRESHOLD:
			average_response_time_growth_direction = AVERAGE_RESPONSE_TIME_GROWTH_DIRECTION.INCREASE
		else :
			average_response_time_growth_direction = AVERAGE_RESPONSE_TIME_GROWTH_DIRECTION.DECREASE


func start() -> void:
	timer.start()
	
	
func stop() -> void:
	timer.stop()
	
func increase(amount: int) -> void:
	average_response_time += amount
	average_response_time_increased.emit(amount)

func decrease(amount: int) -> void:
	average_response_time -= amount
	average_response_time_decreased.emit(amount)

func _on_timer_timeout() -> void:
		if average_response_time_growth_direction == AVERAGE_RESPONSE_TIME_GROWTH_DIRECTION.INCREASE:
			increase(AVERAGE_RESPONSE_TIME_DELTA)
		
		if average_response_time_growth_direction == AVERAGE_RESPONSE_TIME_GROWTH_DIRECTION.DECREASE and average_response_time > MINUMUM_AVERAGE_RESPONSE_TIME:
			decrease(AVERAGE_RESPONSE_TIME_DELTA)
			
		average_response_time_difference_from_initial = average_response_time - INITIAL_AVERAGE_RESPONSE_TIME
		
		
