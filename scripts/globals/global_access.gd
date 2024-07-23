extends Node

# score of each player
var player_data: Array[PlayerData]=[]

# at the end of a given round, this will be called
func game_over(p: PLAYER_ID)->bool:
	if p==null:
		return false
		
	player_data[p].points+=1
	return player_data[p].points>=games_to_win

# number of rounds a match will last
var games_to_win: int=0


var level_to_load: String


func get_winner()->String:
	return PLAYER_ID.find_key(player_data.find(player_data.reduce(func(m,v): return v if v.points>m.points else m)))

# amount of players in-game
var players: int:
	get:
		return player_data.size()

# each player is given one of these
enum PLAYER_ID{
	P1=0,
	P2=1,
	P3=2,
	P4=3,
	}



#region node connections
func get_game_scene()->Node:
	return get_tree().get_first_node_in_group("main_viewport").get_children()[0]

func get_actor_container()->Node2D:
	return get_tree().get_first_node_in_group("Actor Container")

func get_game_manager()->GameManager:
	return get_tree().get_first_node_in_group("Game Manager")
	
func get_level_grid()->TileMap:
	return get_tree().get_first_node_in_group("Level Grid")
#endregion



