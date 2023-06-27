extends PanelContainer

signal start()
signal quit()


func _on_btn_start_pressed():
	start.emit()


func _on_btn_quit_pressed():
	quit.emit()
