extends Paddle

@export var ball: Ball
@export var speed: int = 500

var target:= Vector2.ZERO

func _process(delta):
	var paddel_pos: int = position.y
	
	if ball.velocity.x > 0:
		if paddel_pos > ball.position.y:
			paddel_pos -= speed * delta
		if paddel_pos < ball.position.y:
			paddel_pos += speed * delta

	position.y = clamp(paddel_pos, half_height, get_viewport_rect().size.y - half_height)
