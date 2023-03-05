extends Node2D


@onready var ui = $UI/VBoxContainer/MenuContainer
@onready var lbl_player_score = $UI/VBoxContainer/ScoreContainer/HBoxContainer/lbl_player_score
@onready var lbl_cpu_score = $UI/VBoxContainer/ScoreContainer/HBoxContainer/lbl_cpu_score
@onready var ball = $Ball


func _ready():
	ball.field_size = get_viewport_rect().size
	ball.reset()
	

func _input(event):
	if event.is_action_released("ui_accept"):
		ball.reset()
		ball.start()


func _on_btn_start_button_up():
	print("Button pressed")
	ui.visible = false


func _on_btn_quit_button_up():
	get_tree().quit()
