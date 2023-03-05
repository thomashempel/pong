extends Node2D
class_name Paddle


@export var size:= Vector2(40, 120)
var half_height: int = 0


func _ready():
	half_height = size.y / 2
