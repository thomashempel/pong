extends Paddle

func _process(delta):
	var paddel_pos: int = position.y
	
	if Input.is_action_pressed("ui_up"):
		paddel_pos -= 10
		
	if Input.is_action_pressed("ui_down"):
		paddel_pos += 10
		
	position.y = clamp(paddel_pos, half_height, get_viewport_rect().size.y - half_height)
	
