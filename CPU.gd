extends Paddle

@export var ball: Ball
@export var max_speed: int = 300

var target:= Vector2.ZERO


func _process(delta):
	var paddel_pos: int = position.y

	if ball.velocity.x > 0:
		var speed = randi_range(100, max_speed)

		if paddel_pos > ball.position.y:
			paddel_pos -= speed * delta
		if paddel_pos < ball.position.y:
			paddel_pos += speed * delta

	position.y = clamp(paddel_pos, half_height, get_viewport_rect().size.y - half_height)
