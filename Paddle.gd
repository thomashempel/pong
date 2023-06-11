extends Node2D
class_name Paddle

@export var size:= Vector2(40, 120)

var field_size := Vector2.ZERO
var half_height: int = 0
var paddel_pos: int = 0
var velocity: float = 0.0


func _ready():
	field_size = get_viewport_rect().size
	half_height = size.y / 2


func reset():
	velocity = 0
	position.y = field_size.y / 2


func _process(delta):
	super(delta)

