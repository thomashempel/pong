extends Node2D
class_name Ball

signal ball_hit

#@onready var world: World

var velocity := Vector2.ZERO
var start_speed := 600
var max_speed := 800
var speed := 0
var direction := 1
var field_size := Vector2.ZERO

func _ready():
	randomize()
	field_size = get_viewport_rect().size


func _process(delta):
	if position.y <= 15 or position.y > field_size.y - 15:
		velocity.y *= -1

	position += velocity * delta


func reset():
	speed = 0
	velocity = Vector2.ZERO
	position = Vector2(field_size.x / 2, field_size.y / 2)


func start():
	if speed != 0:
		return

	speed = start_speed
	direction = -1 if randi_range(0, 1) == 0 else 1
	velocity = Vector2(speed * direction, -25 if randi_range(0, 1) == 0 else 25)


func _on_area_2d_area_entered(area):
	if area.get_parent().position.y > position.y:
		velocity.y -= randi_range(50, 200)

	elif area.get_parent().position.y < position.y:
		velocity.y += randi_range(50, 200)

	speed = clampi(speed + 15, 0, max_speed)
	direction *= -1
	velocity.x = speed * direction

	ball_hit.emit()
