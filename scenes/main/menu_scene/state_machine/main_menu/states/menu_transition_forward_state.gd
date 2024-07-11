class_name MenuTransitionForwardState
extends State


func _enter_state()->void:
	var machine: MenuStateMachine=self.machine as MenuStateMachine
	
	
	for l: List2D in machine.final_positions:
		for c: Node in l.get_children():
			if c is Button:
				c.disabled=true
	
	machine.old_list.position=machine.final_positions[machine.old_list]
	machine.old_list.position.y+=14
	
	machine.new_list.position=machine.final_positions[machine.new_list]
	machine.new_list.position.x-=1000
	
	
func _state_process(_delta)->void:
	var machine: MenuStateMachine=self.machine as MenuStateMachine
	machine.new_list.position.x+=(abs(machine.new_list.position.x - machine.final_positions[machine.new_list].x)/5)+1
	machine.old_list.position.y+=(abs(machine.old_list.position.y - machine.final_positions[machine.old_list].y)/5)+1

func _check_switch_conditions()->void:
	var machine: MenuStateMachine=self.machine as MenuStateMachine
	if machine.new_list.position.x>=machine.final_positions[machine.new_list].x:
		switch_to.emit(self, machine.states["MenuStillState"])
