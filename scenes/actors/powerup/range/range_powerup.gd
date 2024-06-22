class_name RangePowerup
extends Powerup


func _apply_powerup(player: Player)->void:
	player.inc_power()
