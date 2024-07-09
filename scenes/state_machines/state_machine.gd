class_name StateMachine
extends Node

@export var initial_state: State

var states: Dictionary={}

var current_state: State


func _ready():
	for c in get_children():
		if c is State: 
			c.switch_to.connect(switch_state)
			c.machine=self
			states[c.name]=c
	states.make_read_only()





func switch_state(new_state: State)->void:
	if current_state!=null:
		current_state.exit_state()
		current_state.set_process(false)
		current_state.set_physics_process(false)
		
	new_state.enter_state()
	new_state.set_process(new_state.idle_update)
	new_state.set_physics_process(new_state.fixed_update)
		
	
	
