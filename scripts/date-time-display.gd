extends Control
class_name DateTimeDisplay

@onready var date_label: Label = %DateLabel
@onready var time_label: Label = %TimeLabel
@onready var minutes_timer: Timer = $MinutesTimer

const DATE_FORMAT: String = "%s/%s/%s"
const TIME_FORMAT: String = "%s:%s"
const ZERO_PADDED_FORMAT: String = "0%s"

var current_minutes: int = 0

var current_date_time: Dictionary:
	set(date_time):
		
		minutes_timer.stop()
		current_minutes = 0
		current_date_time = date_time
		
		_update_date_label_text()
		_update_time_label_text()

		minutes_timer.start()

func _update_date_label_text() -> void:
	date_label.text = DATE_FORMAT % [_left_pad_with_zero(current_date_time.day), _left_pad_with_zero(current_date_time.month), _left_pad_with_zero(current_date_time.year)]

func _update_time_label_text() -> void:
	time_label.text = TIME_FORMAT % [_left_pad_with_zero(current_date_time.hour), _left_pad_with_zero(current_minutes)]

func _left_pad_with_zero(number: int) -> String:
	return ZERO_PADDED_FORMAT % number if number <10 else str(number)

func _on_minutes_timer_timeout() -> void:
	current_minutes +=1
	_update_time_label_text()
