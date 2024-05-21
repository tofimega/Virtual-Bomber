class_name PlayerInputMap
extends Resource


@export var up: String
@export var down: String
@export var left: String
@export var right: String
@export var place_bomb: String

static func get_input_map(id: GlobalAccess.PLAYER_ID)-> PlayerInputMap:
	print("getting input map for player: ",id)
	match id:
		GlobalAccess.PLAYER_ID.P1: return ResourceLoader.load("res://assets/resources/player_input/P1_input_map.tres")
		GlobalAccess.PLAYER_ID.P2: return ResourceLoader.load("res://assets/resources/player_input/P2_input_map.tres")
		GlobalAccess.PLAYER_ID.P3: return ResourceLoader.load("res://assets/resources/player_input/P3_input_map.tres")
	return null
