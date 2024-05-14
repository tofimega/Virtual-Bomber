class_name State
extends Node


func _process(delta):
	_check_switch_conditions()
	_state_process(delta)

func _enter_state()->void:
	pass
func _exit_state()->void:
	pass
func _check_switch_conditions():
	pass
func _state_process(delta: float)->void:
	pass
