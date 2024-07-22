extends Node

# score of each player
var player_data: Array[PlayerData]=[]

# at the end of a given round, this will be called
func game_over(p: PLAYER_ID)->bool:
	if p==null:
		return false
		
	player_data[p].points+=1
	return player_data[p].points>games_to_win

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

signal scene_replaced(new: Node,on: Node)

func emit_scene_replaced(new: Node,on: Node)->void:
	scene_replaced.emit(new,on)


func replace_subscene(old: Node, new: PackedScene, on_thread: Thread)->void:
	if on_thread.is_alive(): return
	if on_thread.is_started(): on_thread.wait_to_finish()
	if new.can_instantiate():
		if old!=null:
			on_thread.start(delayed_replace.bind(old,new.instantiate(),old.get_parent()))
		else:
			on_thread.start(delayed_replace.bind(null,new.instantiate(),old.get_parent()))

func replace_left_scene(new: PackedScene)->void:
	if replacer_thread_left.is_alive(): return
	if replacer_thread_left.is_started(): replacer_thread_left.wait_to_finish()
	if new.can_instantiate():
		var left=get_tree().get_first_node_in_group("left_panel")
		if left.get_children().size()>0:
			var a=left.get_children()[0]
			replacer_thread_left.start(delayed_replace.bind(a,new.instantiate(),left))
		else:
			replacer_thread_left.start(delayed_replace.bind(null,new.instantiate(),left))

func replace_right_scene(new: PackedScene)->void:
	if replacer_thread_right.is_alive(): return
	if replacer_thread_right.is_started(): replacer_thread_right.wait_to_finish()
	if new.can_instantiate():
		var right=get_tree().get_first_node_in_group("right_panel")
		if right.get_children().size()>0:
			var a=right.get_children()[0]
			replacer_thread_right.start(delayed_replace.bind(a,new.instantiate(),right))
		else:
			replacer_thread_right.start(delayed_replace.bind(null,new.instantiate(),right))

func replace_game_scene(new: PackedScene)->void:
	if replacer_thread_main.is_alive(): return
	if replacer_thread_main.is_started(): replacer_thread_main.wait_to_finish()
	if new != null and new.can_instantiate():
		var viewport: SubViewport=get_tree().get_first_node_in_group("main_viewport")
		if viewport.get_children().size()>0:
			var a=viewport.get_children()[0]
			replacer_thread_main.start(delayed_replace.bind(a,new.instantiate(),viewport))
		else:
			replacer_thread_main.start(delayed_replace.bind(null,new.instantiate(),viewport))


var replacer_thread_left: Thread=Thread.new()
var replacer_thread_right: Thread=Thread.new()
var replacer_thread_main: Thread=Thread.new()
func delayed_replace(until_null: Node,what: Node, to: Node)->void:
	if until_null!=null:
		until_null.queue_free()
		while until_null!=null:
			continue
	if what !=null:
		to.add_child.call_deferred(what)
		emit_scene_replaced.call_deferred(what,to)

func get_main_viewport()->SubViewport:
	return get_tree().get_first_node_in_group("main_viewport")
	
func get_left_panel()->Node:
	return get_tree().get_first_node_in_group("left_panel")
func get_right_panel()->Node:
	return get_tree().get_first_node_in_group("right_panel")


func get_game_scene()->Node:
	return get_tree().get_first_node_in_group("main_viewport").get_children()[0]

func get_actor_container()->Node2D:
	return get_tree().get_first_node_in_group("Actor Container")

func get_game_manager()->GameManager:
	return get_tree().get_first_node_in_group("Game Manager")
	
func get_level_grid()->TileMap:
	return get_tree().get_first_node_in_group("Level Grid")
#endregion



