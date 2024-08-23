class_name GameManager
extends Node


var player_spawn_points: Array[Vector2]=[]
var enemy_spawn_points: Array[EnemySpawn]=[]


func _ready():

	SignalBus.player_spawn_ready.connect(add_spawn_point)
	
	SignalBus.enemy_spawn_ready.connect(add_enemy_spawn_point)
	
	SignalBus.level_loaded.connect(start_game, ConnectFlags.CONNECT_DEFERRED)
	SignalBus.round_over.connect(start_next_round)
	
	
	_setup_score_counters()
	_load_level()


func start_game()->void:
	initialize_data()
	spawn_enemies()
	spawn_players()

func initialize_data()->void:
	SignalBus.new_round.emit()



func spawn_enemies()->void:
	for p in enemy_spawn_points:
		var e: BaseEnemy=p.enemy_type.instantiate()
		e.position=p.position
		GlobalAccess.get_actor_container().add_child.call_deferred(e)
		
		p.queue_free()
	enemy_spawn_points.clear()



func add_enemy_spawn_point(p: EnemySpawn)->void:
	enemy_spawn_points.append(p)

func _setup_score_counters()->void:
	pass

func _load_level()->void:
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
		
		GlobalAccess.get_actor_container().players.add_child.call_deferred(player)
		
		player_count+=1
		if player_count>=GlobalAccess.players:
			break


#region game state
func next(over: bool)->void:

	if over:
		SceneControl.replace_game_scene(load("res://scenes/main/results_scene/results.tscn"))
		return
	SceneControl.replace_game_scene(load("res://scenes/main/game_scene/game_scene.tscn"))

	
func start_next_round(status: GameMode.RoundStatus)->void:
	if status ==GameMode.RoundStatus.TIE:
		next(false)
		return
	if status==GameMode.RoundStatus.CONCLUSIVE:
		var winning_id: GlobalAccess.PLAYER_ID=GlobalAccess.game_settings.game_mode.get_winner_of_round()
		GlobalAccess.game_settings.player_data[winning_id].points+=1
		next(GlobalAccess.game_settings.player_data[winning_id].points>=GlobalAccess.game_settings.rounds)



#endregion
