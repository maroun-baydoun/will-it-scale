extends PanelContainer

signal play_again_pressed

var served_days: int = 0:
	set(days):
		%DaysLabel.text = "%s Days" % [days]
		
var served_sessions: int = 0:
	set(sessions):
		%SessionsLabel.text = "%s Sessions" % [sessions]


func _on_play_again_button_pressed() -> void:
	play_again_pressed.emit()
