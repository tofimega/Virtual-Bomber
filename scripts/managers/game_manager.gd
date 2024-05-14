class_name GameManager
extends Node


var active_players: Array=[]
var active_explosions: int=0
var active_bombs: int=0



func _ready():
	_setup_score_counters()
	_load_level()

func _setup_score_counters()->void:
	pass

func _load_level()->void:
	pass
#region incs, decs
func add_player()->void:
	pass
func rem_player()->void:
	pass
	_check_game_state()

func inc_bombs()->void:
	active_bombs+=1
	
func dec_bombs()->void:
	active_bombs-=1
	_check_game_state()
	
func inc_explosions()->void:
	active_explosions+=1
func dec_explosions()->void:
	active_explosions-=1
	_check_game_state()
#endregion
#region game state
func next(over: bool)->void:
	if over:
		pass #TODO: results scene
		return
	pass #TODO: new game
	
func _check_game_state()->void:
	if active_bombs==0 and active_explosions==0:
		
		if active_players.size()==1:
			var over: bool=GlobalAccess.game_over(GlobalAccess.player_id.P1) # TODO: replace when players are added
			next(over)
			return
			
		elif active_players.is_empty():
			next(false)
#endregion
