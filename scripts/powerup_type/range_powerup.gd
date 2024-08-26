class_name RangePowerup
extends PowerupType

@export_range(1,10,1,"or_greater") var increase_by: int=1

func apply_effect(player: Player)->void:
	player.data.explosion_range+=increase_by
