extends StaticBody3D
class_name Cloud

@export var move_direction: int = 1

var distance_travelled: float = 0.0

const SPEED := 0.1
const MAX_DISTANCE_TRAVELLED := 20.0


func _physics_process(delta: float) -> void:
	var new_z := SPEED * move_direction * delta
	
	move_and_collide(Vector3(0, 0, new_z))
	
	distance_travelled += abs(new_z)
	
	if distance_travelled > MAX_DISTANCE_TRAVELLED:
		distance_travelled = 0.0
		move_direction *= -1
	

