extends Node
class_name TrafficManager

var random_number_generator := RandomNumberGenerator.new()

var current_sessions :=0
var current_load := 0.0
var session_computing_cost := 1.0

func generate_traffic() -> void:
	current_sessions = random_number_generator.randi_range(10, 1000)
	current_load = current_sessions * session_computing_cost



