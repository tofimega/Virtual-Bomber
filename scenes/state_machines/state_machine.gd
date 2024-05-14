class_name StateMachine
extends Node

@export var initial_state: State

var current_state: State

# Called when the node enters the scene tree for the first time.
func _ready():
	_switch_scene(initial_state)


func switch_scene(new_state: State)->void:
	if current_state!=null:
		current_state._exit_state()
		current_state.active=false
		
	new_state._enter_state()
	new_state.active=true
		
	
	
