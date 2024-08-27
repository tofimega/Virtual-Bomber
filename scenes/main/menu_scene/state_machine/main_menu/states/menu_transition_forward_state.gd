class_name MenuTransitionForwardState
extends State


func _enter_state()->void:
	var menu_machine: MenuStateMachine=self.machine as MenuStateMachine
	
	
	for l: List2D in menu_machine.final_positions:
		for c: Node in l.get_children():
			if c is Button:
				c.disabled=true
	
	menu_machine.old_list.position=menu_machine.final_positions[menu_machine.old_list]
	menu_machine.old_list.position.y+=14
	
	menu_machine.new_list.position=menu_machine.final_positions[menu_machine.new_list]
	menu_machine.new_list.position.x-=1000
	
	
func _state_process(_delta)->void:
	var menu_machine: MenuStateMachine=self.machine as MenuStateMachine
	menu_machine.new_list.position.x+=(abs(menu_machine.new_list.position.x - menu_machine.final_positions[menu_machine.new_list].x)/5)+1
	menu_machine.old_list.position.y+=(abs(menu_machine.old_list.position.y - menu_machine.final_positions[menu_machine.old_list].y)/5)+1

func _check_switch_conditions()->void:
	var menu_machine: MenuStateMachine=self.machine as MenuStateMachine
	if menu_machine.new_list.position.x>=menu_machine.final_positions[menu_machine.new_list].x:
		switch_to.emit(self, menu_machine.states["MenuStillState"])
