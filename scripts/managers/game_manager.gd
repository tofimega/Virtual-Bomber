class_name GameManager
extends Node


var active_players: Array[Player]=[]
var active_explosions: int=0
var active_bombs: int=0

var player_spawn_points: Array[Vector2]=[]



func _ready():
	SignalBus.player_ready.connect(add_player)
	SignalBus.player_dead.connect(rem_player)
	
	SignalBus.bomb_placed.connect(inc_bombs)
	SignalBus.bomb_exploded.connect(dec_bombs)
	
	SignalBus.new_explosion_on_field.connect(inc_explosions)
	SignalBus.explosion_dissipated.connect(dec_explosions)

	SignalBus.player_spawn_ready.connect(add_spawn_point)
	
	SignalBus.level_loaded.connect(spawn_players)
	
	_setup_score_counters()
	_load_level()




func _setup_score_counters()->void:
	pass

func _load_level()->void:
	GlobalAccess.level_to_load="res://test3.txt"
	var level=ResourceLoader.load("res://scenes/level/test_level/test_level.tscn").instantiate()
	get_parent().add_child.call_deferred(level)

func add_spawn_point(p: PlayerSpawn)->void:
	player_spawn_points.append(p.position)
	p.queue_free()
	print("yea")
	
	
func spawn_players()->void:
	player_spawn_points.shuffle()
	
	var player_count=0

	for i in GlobalAccess.PLAYER_ID:
		var player: Player=ResourceLoader.load("res://scenes/actors/player/player.tscn").instantiate()
		player.id=GlobalAccess.PLAYER_ID[i]
		player.position.x=player_spawn_points[player_count].x
		player.position.y=player_spawn_points[player_count].y
		
		GlobalAccess.get_actor_container().add_child.call_deferred(player)
		
		player_count+=1
		if player_count>=GlobalAccess.players:
			break
	
#region incs, decs
func add_player(p: Player)->void:
	active_players.append(p)
func rem_player(p: Player)->void:
	active_players.erase(p)
	_check_game_state()

func inc_bombs(b)->void:
	active_bombs+=1
	
func dec_bombs(b)->void:
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
		get_tree().change_scene_to_file("res://scenes/main/game_scene.tscn") #TODO: results scene
		return
	get_tree().change_scene_to_file("res://scenes/main/game_scene.tscn")
	
func _check_game_state()->void:
	if active_bombs==0 and active_explosions==0:
		
		if active_players.size()==1:
			var over: bool=GlobalAccess.game_over(active_players[0].id) # TODO: replace when players are added
			next(over)
			return
			
		elif active_players.is_empty():
			next(false)
#endregion
