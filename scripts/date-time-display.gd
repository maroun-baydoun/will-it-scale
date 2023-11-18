extends Control
class_name DateTimeDisplay

@onready var day_label: Label = %DayLabel
@onready var hour_label: Label = %HourLabel
@onready var pause_button: Button = %PauseButton

@onready var pause_icon: CompressedTexture2D = load("res://assets/icons/pause.svg")
@onready var play_icon: CompressedTexture2D = load("res://assets/icons/play.svg")


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
	var is_paused := !get_tree().paused 
	get_tree().paused = is_paused
	
	if is_paused:
		pause_button.icon = play_icon
	else:
		pause_button.icon = pause_icon
