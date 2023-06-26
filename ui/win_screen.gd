extends PanelContainer

signal restart


func show_with_winner(winner: String) -> void:
	%LblTitle.text = winner + " won!"
	visible = true


func _on_btn_restart_button_up():
	visible = false
	restart.emit()


func _on_btn_quit_button_up():
	get_tree().quit()
