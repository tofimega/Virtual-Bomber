class_name GameSettings
extends RefCounted


var player_count: int
var rounds: int

var player_data: Dictionary={}
var level_data: Object # TODO: create class
var game_mode: GameMode

# check if variables above are ok
func validate_data()->bool:
	return true


func get_player_data(id: GlobalAccess.PlayerID)->PlayerData:
	if !player_data.has(id):
		player_data[id]=PlayerData.new()
	player_data[id].id=id
	return player_data[id]
		
func clear_player_data()->void:
	player_data.clear()
