class_name CapacityPowerup
extends Powerup

func _apply_powerup(player: Player)->void:
	player.inc_capacity()
