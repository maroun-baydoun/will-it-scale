extends Node
class_name UserFrustrationManager

signal user_frustration_increased(amount: float)
signal user_frustration_decreased(amount: float)
signal user_frustration_max_reached

@onready var timer: Timer = $Timer

const MAX_USER_FRUSTRATION := 100.0
const USER_FRUSTRATION_DELTA := 1.0
const CURRENT_LOAD_RATIO_THRESHOLD = 0.95

enum USER_FRUSTRATION_GROWTH_DIRECTION {INCREASE, DECREASE}

var user_frustration := 0.0
var user_frustration_growth_direction : USER_FRUSTRATION_GROWTH_DIRECTION

var current_load_ratio := 0.0 :
	set(ratio):
		current_load_ratio = ratio
		if current_load_ratio > CURRENT_LOAD_RATIO_THRESHOLD:
			user_frustration_growth_direction = USER_FRUSTRATION_GROWTH_DIRECTION.INCREASE
		else :
			user_frustration_growth_direction = USER_FRUSTRATION_GROWTH_DIRECTION.DECREASE


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
