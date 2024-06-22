class_name Powerup
extends Area2D



func _apply_powerup()->void:
	print("oh yeah")


func _on_body_entered(body: Player):
	_apply_powerup()
	queue_free()
