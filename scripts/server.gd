extends MeshInstance3D

class_name Server

@onready var height: float = mesh.get_aabb().size.y
@onready var price_label: Label3D = $PriceLabel
@onready var level_label: Label3D = $LevelLabel

const INITIAL_COMPUTING_POWER: int = 100

var computing_power: int = INITIAL_COMPUTING_POWER
var hourly_power_consumption: int = 1 #kWh
var price: int = 1000
var level: int = 3:
	set(l):
		level = l
		level_label.text = str(l)


	
func appear(origin: Vector3):
	transform.origin = origin
	transform.origin.y = -height
	
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_BOUNCE)
	
	tween.tween_property(self, "transform:origin:y", height / 2 , 0.5)

	animate_price()


func animate_price():
	price_label.text = str(-1 * price)
	price_label.transform.origin.y = 0
	
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	
	tween.tween_property(price_label, "transform:origin:y", height * 1.5, 0.7)
	tween.tween_property(price_label, "modulate:a", 0, 0.2)

func _on_static_body_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_mask == MOUSE_BUTTON_LEFT:
			pass
	
