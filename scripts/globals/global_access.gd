extends Node

# score of each player


var game_settings: GameSettings







var level_to_load: String


func get_winner()->String:
	return PlayerID.find_key(game_settings.player_data.values().find(game_settings.player_data.values().reduce(func(m,v): return v if v.points>m.points else m)))

# amount of players in-game
var players: int:
	get:
		return game_settings.player_data.size()

# each player is given one of these
enum PlayerID{
	P1=0,
	P2=1,
	P3=2,
	P4=3,
	}



#region node connections
func get_game_scene()->Node:
	return get_tree().get_first_node_in_group("main_viewport").get_children()[0]

func get_actor_container()->ActorContainer:
	return get_tree().get_first_node_in_group("Actor Container")

func get_game_manager()->GameManager:
	return get_tree().get_first_node_in_group("Game Manager")
	
func get_level_grid()->TileMapContainer:
	return get_tree().get_first_node_in_group("Level Grid")
#endregion
