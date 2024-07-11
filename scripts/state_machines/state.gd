class_name State
extends Node

var machine: StateMachine:
	set(m):
		if machine==null:
			machine=m
			machine.ready.connect(_setup_state_connections)


@export var idle_update: bool=true:
	set(i):
		idle_update=i
		set_process(i and is_processing())
@export var fixed_update: bool=false:
	set(f):
		fixed_update=f
		set_physics_process(f and is_physics_processing())

signal switch_to(new_state: State)


func _process(delta):
	_check_switch_conditions()
	_state_process(delta)

func _physics_process(delta):
	_check_switch_conditions()
	_state_physics_process(delta)

func _setup_state_connections()->void:
	pass

func _enter_state()->void:
	pass
func _exit_state()->void:
	pass
func _check_switch_conditions():
	pass

func _state_physics_process(delta: float)->void:
	pass
func _state_process(delta: float)->void:
	pass
