class_name GameManager
extends Node


var active_players: Array[Player]=[]
var active_explosions: int=0
var active_bombs: int=0

var player_spawn_points: Array[Vector2]=[]
var enemy_spawn_points: Array[EnemySpawn]=[]


func _ready():
	SignalBus.player_ready.connect(add_player)
	SignalBus.player_dead.connect(rem_player)
	
	SignalBus.bomb_placed.connect(inc_bombs)
	SignalBus.bomb_exploded.connect(dec_bombs)
	
	SignalBus.new_explosion_on_field.connect(inc_explosions)
	SignalBus.explosion_dissipated.connect(dec_explosions)

	SignalBus.player_spawn_ready.connect(add_spawn_point)
	
	SignalBus.enemy_spawn_ready.connect(add_enemy_spawn_point)
	
	SignalBus.level_loaded.connect(start_game)
	
	_setup_score_counters()
	_load_level()


func start_game()->void:
	initialize_data()
	spawn_enemies()
	spawn_players()

func initialize_data()->void:
	var pd: Array[PlayerData]=GlobalAccess.player_data
	for a: PlayerData in pd:
		a.range=1
		a.capacity=1
		a.bomb_count=0



func spawn_enemies()->void:
	for p in enemy_spawn_points:
		var e: BaseEnemy=p.enemy_type
		e.position=p.position
		GlobalAccess.get_actor_container().add_child.call_deferred(e)
		
		p.queue_free()
	enemy_spawn_points.clear()



func add_enemy_spawn_point(p: EnemySpawn)->void:
	enemy_spawn_points.append(p)

func _setup_score_counters()->void:
	pass

func _load_level()->void:
	GlobalAccess.level_to_load="res://spriteTest.txt"
	var level=preload("res://scenes/level/test_level/test_level.tscn").instantiate()
	GlobalAccess.get_game_scene().add_child.call_deferred(level)

func add_spawn_point(p: PlayerSpawn)->void:
	player_spawn_points.append(p.position)
	p.queue_free()
	print("yea")
	
	
func spawn_players()->void:
	player_spawn_points.shuffle()
	
	var player_count=0

	for i in GlobalAccess.PLAYER_ID:
		var player: Player=preload("res://scenes/actors/player/player.tscn").instantiate()
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
		GlobalAccess.replace_game_scene(load("res://scenes/main/game_scene.tscn")) #TODO: results scene
		return
	GlobalAccess.replace_game_scene(load("res://scenes/main/game_scene.tscn"))
	game_finished=true
	
	
var game_finished: bool=false
func _check_game_state()->void:
	if game_finished: return
	
	
	if active_bombs==0 and active_explosions==0:
		
		if active_players.size()==1:
			var over: bool=GlobalAccess.game_over(active_players[0].id)
			next(over)
			return
			
		elif active_players.is_empty():
			next(false)
#endregion
