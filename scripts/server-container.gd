extends Node
class_name ServerContiner

signal computing_power_updated(computing_power:int)

@onready var total_computing_power:int:
	set(computing_power):
		total_computing_power = computing_power
		computing_power_updated.emit(total_computing_power)


func add_server(server: Server):
	total_computing_power += server.computing_power
	add_child(server)
