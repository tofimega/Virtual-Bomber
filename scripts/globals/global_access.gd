extends Node

# score of each player
var player_progress: Array[int]=[0,0,0]

# at the end of a given round, this will be called
func game_over(p: String)->bool:
	if p==null:
		return false
		
	player_progress[PLAYER_ID]+=1
	return player_progress[PLAYER_ID]>games_to_win

# number of rounds a match will last
var games_to_win: int=0


var level_to_load: String="res://test3.txt"


func get_winner()->String:
	return PLAYER_ID.find_key(player_progress.find(player_progress.max()))

# amount of players in-game
var players: int=3

# each player is given one of these
enum PLAYER_ID{
	P1=0,
	P2=1,
	P3=2,
	}

#region controls

#endregion
