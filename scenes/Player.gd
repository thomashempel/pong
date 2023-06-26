extends Paddle
class_name Player

@export var speed: int = 20

var angle: float = 0.0


func _process(_delta):
	paddel_pos = position.y

	if Input.is_action_pressed("ui_up"):
		paddel_pos -= speed

	if Input.is_action_pressed("ui_down"):
		paddel_pos += speed

	position.y = clamp(paddel_pos, half_height, get_viewport_rect().size.y - half_height)

