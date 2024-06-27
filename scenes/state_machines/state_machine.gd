class_name StateMachine
extends Node

@export var initial_state: State
@export var extra_states: Array[State]


var current_state: State

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().ready.connect(start)

func start()->void:
	var c=get_children()
	
	
	
	switch_state(initial_state)

func switch_state(new_state: State)->void:
	if current_state!=null:
		current_state.exit_state()
		current_state.set_process(false)
		
		
	new_state.enter_state()
	new_state.set_process(true)
		
	
	
