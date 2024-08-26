class_name CapacityPowerup
extends PowerupType

@export_range(1,10,1,"or_greater") var expand_by: int=1

func apply_effect(player: Player)->void:
	player.data.capacity+=expand_by
