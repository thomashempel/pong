extends Node2D
class_name World


@export var lbl_player_score: Label
@export var lbl_cpu_score: Label

@export var goal_player: Goal
@export var goal_cpu: Goal

@export var win_particles: PackedScene

@export_group("Audio")
@export var audio_explosion: AudioStream
@export var audio_start: AudioStream
@export var audio_win: AudioStream
@export var audio_loose: AudioStream

@onready var ui = %MenuMain

@onready var ball = $Ball
@onready var player = $Player
@onready var cpu = $CPU

@onready var camera = %Camera
@onready var sfx_player = $SfxPlayer

@export_range(1, 21) var winning_score: int = 1

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
var score_player: int = 0:
	set(value):
		score_player = value
		lbl_player_score.text = str(score_player)

var score_cpu: int = 0:
	set(value):
		score_cpu = value
		lbl_cpu_score.text = str(score_cpu)



func _ready():
	reset()
	game_state = GameState.PAUSED


func reset():
	score_player = 0
	score_cpu = 0
	ball.reset()
	player.reset()
	cpu.reset()
	ball.visible = false
	game_state = GameState.READY


func play():
	ball.reset()
	ball.start()
	ball.visible = true
	game_state = GameState.PLAYING
	play_sfx(audio_start)


func check_score(score: int, for_name: String):
	ball.reset()
	game_state = GameState.READY

	if score >= winning_score:
		if for_name == "CPU":
			play_sfx(audio_loose)
		else:
			play_sfx(audio_win)
			
		%WinScreen.show_with_winner(for_name)
		reset()


func _input(event):
	if event.is_action_pressed("toggle_crt"):
		$CrtShader.visible = not $CrtShader.visible
		
	if event.is_action_released("ui_accept"):
		if game_state == GameState.READY:
			play()


func _on_start():
	ui.visible = false
	ball.visible = true
	play()


func _on_quit():
	get_tree().quit()


func _on_player_goal_area_entered(area):
	if area.get_parent() is Ball:
		var p_instance = win_particles.instantiate() as Node2D
		add_child(p_instance)
		p_instance.global_position = area.get_parent().global_position
		p_instance.scale.x = -1

		score_cpu += 1
		camera.set_shake(1.0)
		play_sfx(audio_explosion)

		lbl_cpu_score.text = str(score_cpu)
		check_score(score_cpu, "CPU")


func _on_cpu_goal_area_entered(area):
	if area.get_parent() is Ball:
		var p_instance = win_particles.instantiate() as Node2D
		add_child(p_instance)
		p_instance.global_position = area.get_parent().global_position

		score_player += 1
		camera.set_shake(1.0)
		play_sfx(audio_explosion)
		
		lbl_player_score.text = str(score_player)
		check_score(score_player, "Player")


func _on_win_screen_restart():
	play()


func _on_ball_ball_hit(strength: float):
	camera.set_shake(strength)


func play_sfx(audio: AudioStream) -> void:
	sfx_player.stream = audio
	sfx_player.play()
