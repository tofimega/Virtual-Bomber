class_name NewPlayerButton
extends Button

func _on_pressed():
	SignalBus.request_add_player.emit()
