extends Node
class_name ServerManager

signal computing_power_updated(computing_power:int)

var servers : Array[Server] = []

var total_computing_power: int = 0

const UNSELECTED_SERVER_ID: int = -1

var first_selected_server_id: int = UNSELECTED_SERVER_ID
var second_selected_server_id: int = UNSELECTED_SERVER_ID


func add_server(server: Server):
	server.selected.connect(self._on_server_selected)
	servers.append(server)

	
	total_computing_power += server.computing_power
	computing_power_updated.emit(total_computing_power)
	
func _on_server_selected(server: Server):
	_set_servers_selectable(servers, false)
	
	if first_selected_server_id == UNSELECTED_SERVER_ID:
		var servers_with_same_level = _get_servers_by_level(server.level)
		var selectable_servers = servers_with_same_level.filter(func(other_server: Server): return other_server.id != server.id)
		
		_set_servers_selectable(selectable_servers, true)
		
		first_selected_server_id = server.id
		
	else :
		second_selected_server_id = server.id
	
	
func _get_servers_by_level(level: int):
	return servers.filter(func(server: Server): return server.level == level)

func _set_servers_selectable(servers:Array[Server], selectable:bool ):
	for server in servers:
		server.is_selectable = selectable
