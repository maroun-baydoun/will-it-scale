extends MeshInstance3D

class_name Server

signal selected(server: Server)
signal unselected(server: Server)

@onready var height: float = mesh.get_aabb().size.y
@onready var price_label: Label3D = $PriceLabel
@onready var level_label: Label3D = $LevelLabel
@onready var original_albedo_color: Color = self.get_active_material(0).albedo_color
@onready var animation_player: AnimationPlayer = $AnimationPlayer

const INITIAL_COMPUTING_POWER: int = 100

static var CURRENT_ID: int = 1;

var id: int = 0;
var computing_power: int = INITIAL_COMPUTING_POWER
var hourly_power_consumption: int = 1 #kWh
var price: int = 1000
var level: int = 1:
	set(l):
		level = l
		level_label.text = str(l)

var is_selected: bool = false:
	set(s):
		is_selected = s
		if is_selected:
			animation_player.play("blink")
		else :
			animation_player.stop()
				
			

var is_selectable_for_merge: bool = true:
	set(s):
		is_selectable_for_merge = s

	
func _ready() -> void:
	self.id = Server.CURRENT_ID
	Server.CURRENT_ID +=1
		

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
			
			if self.is_selected:
				self.is_selected = false
				self.unselected.emit(self)

			elif self.is_selected == false:
				if not self.is_selectable_for_merge:
					return

				self.is_selected = true
				self.selected.emit(self)
				
	
