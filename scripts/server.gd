extends MeshInstance3D

class_name Server

const INITIAL_COMPUTING_POWER: int = 100

var computing_power: int = INITIAL_COMPUTING_POWER
var price: int = 1000

@onready var height: float = mesh.size.y
@onready var price_label: Label3D = $PriceLabel
	

	
func appear(origin: Vector3):
	transform.origin = origin
	transform.origin.y = -height
	
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_BOUNCE)
	
	tween.tween_property(self, "transform:origin:y", height / 2, 0.5)
	

	animate_price()


func animate_price():
	price_label.text = str(-1 * price)
	price_label.transform.origin.y = 0
	
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	
	tween.tween_property(price_label, "transform:origin:y", height * 1.5, 0.7)
	tween.tween_property(price_label, "modulate:a", 0, 0.2)
