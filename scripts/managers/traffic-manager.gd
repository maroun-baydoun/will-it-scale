extends Node
class_name TrafficManager

var random_number_generator := RandomNumberGenerator.new()

var current_sessions := 0
var total_sessions := 0
var current_load := 0.0
var session_computing_cost := 1.0
var served_sessions := 0
var current_load_ratio := 0.0

var initial_sessions := 1.0
var previous_sessions := 0
var handleable_load := 0.0

func generate_traffic(computing_power: float, day: int) -> void:
	handleable_load = computing_power
	previous_sessions = current_sessions
	current_sessions = _generate_sessions(day)
	total_sessions += current_sessions

	current_load = current_sessions * session_computing_cost
	
	var handled_load := handleable_load if current_load > handleable_load else current_load
	served_sessions = handled_load / session_computing_cost
	current_load_ratio = 0.0 if handleable_load == 0 else current_load / handleable_load
	
func _generate_sessions(day: int) -> int:
	var day_growth := pow(1.01, day)
	var load_decay :=  log(handleable_load / 300)

	var rand_lower_range := -day_growth * 0.5 / maxf(load_decay, 1.0)
	var rand_upper_range := day_growth * 1.1 / maxf(load_decay, 1.0)
	
	var rand_session_growth := random_number_generator.randf_range(rand_lower_range, rand_upper_range)
	var new_sessions = abs(previous_sessions + rand_session_growth * 10.0 )
	
	if current_load_ratio == 0.0:
		return new_sessions
	if current_load_ratio >= 1.0:
		return new_sessions / (current_load_ratio * 1.05)

	return new_sessions
	
	

