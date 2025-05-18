extends Node
class_name ServerManager

signal computing_power_updated(computing_power:int)
signal server_removed(server: Server)

var servers : Array[Server] = []
var total_computing_power: int = 0:
	set(p):
		total_computing_power = p
		computing_power_updated.emit(total_computing_power)

const UNSELECTED_SERVER_ID: int = -1

var first_selected_server_id: int = UNSELECTED_SERVER_ID
var second_selected_server_id: int = UNSELECTED_SERVER_ID


func add_server(server: Server):
	server.selected.connect(self._on_server_selected)
	server.unselected.connect(self._on_server_unselected)
	server.computing_power_updated.connect(self._on_server_computing_power_updated)
	servers.append(server)

	total_computing_power += server.computing_power
	
func _on_server_computing_power_updated(old_computing_power:int, new_computing_power: int):
	total_computing_power -= old_computing_power
	total_computing_power += new_computing_power
	pass
	
func _on_server_unselected(server: Server): 
	if server.id == first_selected_server_id:
		first_selected_server_id = UNSELECTED_SERVER_ID
	
func _on_server_selected(server: Server):
	_set_servers_selectable(servers, false)
	
	if first_selected_server_id == UNSELECTED_SERVER_ID:
		var servers_with_same_level = _get_servers_by_level(server.level)
		var selectable_servers = servers_with_same_level.filter(func(other_server: Server): return other_server.id != server.id)
		
		_set_servers_selectable(selectable_servers, true)
		
		first_selected_server_id = server.id
		
	else :
		var first_server = _get_server_by_id(first_selected_server_id)
		
		if not first_server:
			return
			
		server_removed.emit(first_server)
		
		var computing_power_to_remove = first_server.computing_power
		
		first_server.queue_free()
		servers.erase(first_server)
		
		total_computing_power -= computing_power_to_remove
		
		server.level += server.level
		server.computing_power *= 2
		
		first_selected_server_id = UNSELECTED_SERVER_ID
		second_selected_server_id = UNSELECTED_SERVER_ID
		
		server.is_selected = false
		
		_set_servers_selectable(servers, true)
		
		

func _get_server_by_id(id: int):
	var found_server: Server
	
	for server in servers:
		if server.id == id:
			found_server = server
			break
			
	return found_server
	
func _get_servers_by_level(level: int):
	return servers.filter(func(server: Server): return server.level == level)

func _set_servers_selectable(servers:Array[Server], selectable:bool ):
	for server in servers:
		server.is_selectable_for_merge = selectable
		
