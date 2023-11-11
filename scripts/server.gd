extends MeshInstance3D

class_name Server

const INITIAL_COMPUTING_POWER: int = 100

var computing_power: int = INITIAL_COMPUTING_POWER


@onready var height: float = mesh.size.y
	

	
func appear(origin: Vector3):
	transform.origin = origin
	transform.origin.y = -height
	
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_BOUNCE)
	
	tween.tween_property(self, "transform:origin:y", height / 2, 0.5)
	



