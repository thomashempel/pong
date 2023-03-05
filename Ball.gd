extends Node2D
class_name Ball

var velocity := Vector2.ZERO
var start_speed := 300
var max_speed := 600
var speed := 0
var field_size := Vector2.ZERO
var direction := 1


func _ready():
	randomize()


func _process(delta):
	if position.y <= 15 or position.y > field_size.y - 15:
		velocity.y *= -1
	
	position += velocity * delta
	
	if position.x < 0:
		print("CPU scored")
		reset()
	if position.x > field_size.x:
		print("Player scored")
		reset()


func reset():
	speed = 0
	velocity = Vector2.ZERO
	position = Vector2(field_size.x / 2, field_size.y / 2)


func start():
	if speed != 0:
		return
		
	speed = start_speed
	direction = -1 if randi_range(0, 1) == 0 else 1
	var up = randi_range(0, 1) == 0
	velocity = Vector2(speed * direction, -25 if up else 25)


func _on_area_2d_area_entered(area):
	if area.get_parent().position.y > position.y:
		velocity.y -= randi_range(15, 50)
	elif area.get_parent().position.y < position.y:
		velocity.y += randi_range(15, 50)
		
	speed = clampi(speed + 5, 0, max_speed)
	direction *= -1
	velocity.x = speed * direction
