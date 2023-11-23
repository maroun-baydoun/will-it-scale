extends Control
class_name ProgressBars


@onready var user_frustration_progress_bar : TextureProgressBar = %UserFrustrationProgressBar

var user_frustration: int:
	set(frustration):
		user_frustration = frustration
		get_tree().create_tween().tween_property(user_frustration_progress_bar,"value", user_frustration * 10, 1 )
		#user_frustration_progress_bar.value = user_frustration
