extends Node
class_name ResponseTimeManager

enum AVERAGE_RESPONSE_TIME_GROWTH_DIRECTION {INCREASE, DECREASE}

const MINIMUM_AVERAGE_RESPONSE_TIME := 200 #ms
const INITIAL_AVERAGE_RESPONSE_TIME := 300 #ms
const AVERAGE_RESPONSE_TIME_DELTA := 10 #ms
const CURRENT_LOAD_RATIO_THRESHOLD = 0.95

var average_response_time := INITIAL_AVERAGE_RESPONSE_TIME
var average_response_time_difference_from_initial := 0
var average_response_time_growth_direction : AVERAGE_RESPONSE_TIME_GROWTH_DIRECTION

var delta := AVERAGE_RESPONSE_TIME_DELTA


var current_load_ratio := 0.0 :
	set(ratio):
		current_load_ratio = ratio
		var diff = (INITIAL_AVERAGE_RESPONSE_TIME * (current_load_ratio / CURRENT_LOAD_RATIO_THRESHOLD) )
		
		if current_load_ratio > CURRENT_LOAD_RATIO_THRESHOLD:
			delta = AVERAGE_RESPONSE_TIME_DELTA - diff
			average_response_time_growth_direction = AVERAGE_RESPONSE_TIME_GROWTH_DIRECTION.INCREASE
		else :
			delta = AVERAGE_RESPONSE_TIME_DELTA + diff
			average_response_time_growth_direction = AVERAGE_RESPONSE_TIME_GROWTH_DIRECTION.DECREASE
		
		average_response_time = max((current_load_ratio / CURRENT_LOAD_RATIO_THRESHOLD) * INITIAL_AVERAGE_RESPONSE_TIME, MINIMUM_AVERAGE_RESPONSE_TIME)
		average_response_time_difference_from_initial = average_response_time - INITIAL_AVERAGE_RESPONSE_TIME
