extends Node




signal scene_replaced(new: Node,on: Node)


func process(delta: float)->void:
	if Input.is_action_just_pressed("P4_BOMB"):
		get_tree().paused=!get_tree().paused

func replace_subscene(parent: Node,old: Node, new: PackedScene, on_thread: Thread)->void:
	if !new.can_instantiate(): return
	if on_thread.is_alive(): return
	if on_thread.is_started(): on_thread.wait_to_finish()
	on_thread.start(delayed_replace.bind(old,new.instantiate(),parent))


func replace_left_scene(new: PackedScene)->void:
	var old: Node
	if get_left_panel().get_child_count()==0:
		old=null
	else:
		old=get_left_panel().get_children()[0]
	
	replace_subscene(get_left_panel(),old,new,replacer_thread_left)

func replace_right_scene(new: PackedScene)->void:
	var old: Node
	if get_right_panel().get_child_count()==0:
		old=null
	else:
		old=get_right_panel().get_children()[0]
		
	replace_subscene(get_right_panel(),old,new,replacer_thread_right)

func replace_game_scene(new: PackedScene)->void:
	var old: Node
	if get_main_viewport().get_child_count()==0:
		old=null
	else:
		old=get_main_viewport().get_children()[0]
		
	replace_subscene(get_main_viewport(),old,new,replacer_thread_main)

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
		scene_replaced.emit.call_deferred(what, to)


func get_main_viewport()->SubViewport:
	return get_tree().get_first_node_in_group("main_viewport")
func get_left_panel()->Node:
	return get_tree().get_first_node_in_group("left_panel")
func get_right_panel()->Node:
	return get_tree().get_first_node_in_group("right_panel")
