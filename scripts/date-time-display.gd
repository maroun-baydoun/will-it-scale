extends Control
class_name DateTimeDisplay

signal paused
signal resumed

@onready var day_label: Label = %DayLabel
@onready var hour_label: Label = %HourLabel
@onready var pause_button: Button = %PauseButton
@onready var play_button: Button = %PlayButton
@onready var fast_forward_button: Button = %FastForwardButton


const DAY_FORMAT: String = "Day: %s"
const TIME_FORMAT: String = "%s:%s"
const ZERO_PADDED_FORMAT: String = "0%s"


var current_day: int:
	set(day):
		current_day = day
		_update_day_label_text()

var current_hour: int:
	set(hour):
		current_hour = hour
		_update_hour_label_text()


func _update_day_label_text() -> void:
	day_label.text = DAY_FORMAT % [current_day]

func _update_hour_label_text() -> void:
	hour_label.text = TIME_FORMAT % [_left_pad_with_zero(current_hour),  "00"]

func _left_pad_with_zero(number: int) -> String:
	return ZERO_PADDED_FORMAT % number if number <10 else str(number)


func _on_pause_button_pressed() -> void:
	get_tree().paused = true
	
	play_button.disabled = false
	fast_forward_button.disabled = false
	pause_button.disabled = true
	
	paused.emit()
	

func _on_play_button_pressed() -> void:
	get_tree().paused = false
	Engine.time_scale = 1.0
	
	play_button.disabled = true
	pause_button.disabled = false
	fast_forward_button.disabled = false
	
	resumed.emit()


func _on_fast_forward_button_pressed() -> void:
	get_tree().paused = false
	Engine.time_scale = 20.0
	
	fast_forward_button.disabled = true
	play_button.disabled = false
	pause_button.disabled = false
