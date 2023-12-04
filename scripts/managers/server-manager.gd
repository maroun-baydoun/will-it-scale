extends Node
class_name ServerManager

signal computing_power_updated(computing_power:int)

var total_computing_power: int = 0


func add_server(server: Server):
	total_computing_power += server.computing_power
	computing_power_updated.emit(total_computing_power)
