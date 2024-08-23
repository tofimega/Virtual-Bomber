class_name PlayerInputMap
extends Resource


@export var up: String
@export var down: String
@export var left: String
@export var right: String
@export var place_bomb: String

static func get_input_map(id: GlobalAccess.PlayerID)-> PlayerInputMap:
	print("getting input map for player: ",id)
	match id:
		GlobalAccess.PlayerID.P1: return ResourceLoader.load("res://assets/resources/player_input/P1_input_map.tres")
		GlobalAccess.PlayerID.P2: return ResourceLoader.load("res://assets/resources/player_input/P2_input_map.tres")
		GlobalAccess.PlayerID.P3: return ResourceLoader.load("res://assets/resources/player_input/P3_input_map.tres")
		GlobalAccess.PlayerID.P4: return ResourceLoader.load("res://assets/resources/player_input/P4_input_map.tres")
	
	return null
