class_name StateMachine
extends Node

@export var initial_state: State

var states: Dictionary={}

var current_state: State=null


func _ready():
	for c in get_children():
		if c is State: 
			c.switch_to.connect(switch_state)
			c.machine=self
			states[c.name]=c
	states.make_read_only()
	for s in states:
		states[s]._setup_state_connections()
		states[s].set_process(false)
		states[s].set_physics_process(false)


func start()->void:
	switch_state(null, initial_state)

func switch_state(old_state: State,new_state: State)->void:
	if old_state!=current_state and current_state!=null: return
	if new_state==current_state: return
	print("old state: ", old_state, "new state: ", new_state)
	if current_state!=null:
		current_state._exit_state()
		current_state.set_process(false)
		current_state.set_physics_process(false)
		
	new_state._enter_state()
	new_state.set_process(new_state.idle_update)
	new_state.set_physics_process(new_state.fixed_update)
	current_state=new_state


	
