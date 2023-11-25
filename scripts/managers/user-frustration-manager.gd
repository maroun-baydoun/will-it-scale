extends Node
class_name UserFrustrationManager

signal user_frustration_increased(amount: float)
signal user_frustration_decreased(amount: float)
signal user_frustration_max_reached

@onready var timer: Timer = $Timer

enum USER_FRUSTRATION_GROWTH_DIRECTION {INCREASE, DECREASE}

const MAX_USER_FRUSTRATION := 100.0
const USER_FRUSTRATION_DELTA := 1.0

var user_frustration := 0.0
var user_frustration_growth_direction : USER_FRUSTRATION_GROWTH_DIRECTION

var average_response_time_difference_from_initial := 0:
	set(difference):
		average_response_time_difference_from_initial = difference
		if difference < 0:
			user_frustration_growth_direction = USER_FRUSTRATION_GROWTH_DIRECTION.DECREASE
		elif difference > 0 :
			user_frustration_growth_direction = USER_FRUSTRATION_GROWTH_DIRECTION.INCREASE


func start() -> void:
	timer.start()
	
func stop() -> void:
	timer.stop()

func increase(amount: float) -> void:
	user_frustration += amount
	user_frustration_increased.emit(amount)


func decrease(amount: float) -> void:
	user_frustration -= amount
	user_frustration_decreased.emit(amount)


func _on_timer_timeout() -> void:
	if user_frustration_growth_direction == USER_FRUSTRATION_GROWTH_DIRECTION.INCREASE and user_frustration < MAX_USER_FRUSTRATION:
		increase(USER_FRUSTRATION_DELTA)
		
	if user_frustration_growth_direction == USER_FRUSTRATION_GROWTH_DIRECTION.DECREASE and user_frustration >= USER_FRUSTRATION_DELTA:
		decrease(USER_FRUSTRATION_DELTA)
		
	if user_frustration == MAX_USER_FRUSTRATION:
		user_frustration_max_reached.emit()
