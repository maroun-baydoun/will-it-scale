extends Node
class_name TrafficManager

var random_number_generator := RandomNumberGenerator.new()

var current_sessions := 0
var current_load := 0.0
var session_computing_cost := 1.0
var served_sessions := 0

var initial_sessions := 1.0
var previous_sessions := 0

func generate_traffic(handleable_load: float, day: int) -> void:
	current_sessions = _generate_sessions(day)
	current_load = current_sessions * session_computing_cost
	
	var handled_load := handleable_load if current_load > handleable_load else current_load
	served_sessions = handled_load / session_computing_cost
	
	
func _generate_sessions(day: int) -> int:
	var delta := initial_sessions * pow(1.01, day)
	
	return previous_sessions + round(random_number_generator.randf_range(delta, delta * 2) * 100.0)
	
