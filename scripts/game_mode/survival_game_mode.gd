class_name SurvivalGameMode
extends GameMode

const END_GAME_TIMEOUT: float=4

var players_remaining: int

var dead_players: Array[GlobalAccess.PlayerID]=[]

var timer_finished: bool=false:
	set(f):
		timer_finished=f
		if f==true:
			SignalBus.round_over.emit(is_round_over())


func _init()->void:
	super()
	SignalBus.player_dead.connect(dec_players)

func setup_round()->void:
	dead_players.clear()
	players_remaining=GlobalAccess.game_settings.player_count
	timer_finished=false
	
func dec_players(p: GlobalAccess.PlayerID)->void:
	dead_players.append(p)
	players_remaining-=1
	if players_remaining<=1:
		var timer: SceneTreeTimer=SceneControl.get_left_panel().get_tree().create_timer(END_GAME_TIMEOUT)
		timer.timeout.connect(func(): timer_finished=true)

func is_round_over()->GameMode.RoundStatus:
	if timer_finished:
		if players_remaining==1:
			return RoundStatus.CONCLUSIVE
		elif players_remaining<=0:
			return RoundStatus.TIE
	return RoundStatus.IN_PROGRESS
		

func get_winner_of_round()->GlobalAccess.PlayerID:
	for p: GlobalAccess.PlayerID in GlobalAccess.game_settings.player_data:
		if GlobalAccess.game_settings.player_data[p].id not in dead_players:
			return p
	return GlobalAccess.PlayerID.P1
