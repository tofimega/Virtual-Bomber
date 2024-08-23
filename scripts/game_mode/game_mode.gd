class_name GameMode
extends Resource

@export var mode_name: String

@export_multiline var mode_description: String


enum RoundStatus{
	IN_PROGRESS,
	CONCLUSIVE,
	TIE
}


func _init()->void:
	SignalBus.new_round.connect(setup_round)


func setup_round()->void:
	pass


func is_round_over()->RoundStatus:
	return RoundStatus.IN_PROGRESS

func get_winner_of_round()->GlobalAccess.PlayerID:
	return 0 as GlobalAccess.PlayerID

func is_level_compatible(level_data: Object)->bool:
	return true
