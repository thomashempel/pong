extends Node2D
class_name World


@onready var ui = $UI/VBoxContainer/MenuContainer

@export var lbl_player_score: Label
@export var lbl_cpu_score: Label

@export var goal_player: Goal
@export var goal_cpu: Goal

@onready var ball = $Ball
@onready var player = $Player
@onready var cpu = $CPU

@export_range(1, 21) var winning_score: int = 10

enum GameState {
	READY,
	PLAYING,
	PAUSED
}

enum Entity {
	Player,
	Cpu
}

var game_state: GameState = GameState.READY
var score_player: int = 0
var score_cpu: int = 0



func _ready():
	reset()


func reset():
	score_player = 0
	score_cpu = 0
	ball.reset()
	player.reset()
	cpu.reset()
	game_state = GameState.READY


func play():
	ball.reset()
	ball.start()
	game_state = GameState.PLAYING


func check_score(score: int, name: String):
	ball.reset()

	if score >= winning_score:
		print(name, " WON!")
		reset()


func _input(event):
	if event.is_action_released("ui_accept"):
		play()


func _on_btn_start_button_up():
	print("Button pressed")
	ui.visible = false


func _on_btn_quit_button_up():
	get_tree().quit()


func _on_player_goal_area_entered(area):
	if area.get_parent() is Ball:
		score_cpu += 1
		lbl_cpu_score.text = str(score_cpu)
		check_score(score_cpu, "CPU")


func _on_cpu_goal_area_entered(area):
	if area.get_parent() is Ball:
		score_player += 1
		lbl_player_score.text = str(score_player)
		check_score(score_player, "Player")

