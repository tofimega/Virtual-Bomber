extends Node

# score of each player
var player_progress: Array[int]=[0,0,0]

# at the end of a given round, this will be called
func game_over(p: player_id)->bool:
	if p==null:
		return false
		
	player_progress[p]+=1
	return player_progress[p]>games_to_win

# number of rounds a match will last
var games_to_win: int=0


func get_winner()->player_id:
	return player_id.find_key(player_progress.find(player_progress.max()))

# amount of players in-game
var players: int=2:
	get:
		return players
	set (p):
		players=p
		
		
# each player is given one of these
enum player_id{
	P1,
	P2,
	P3,
}
