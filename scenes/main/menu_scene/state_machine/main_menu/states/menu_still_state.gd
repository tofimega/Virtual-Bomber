class_name MenuStillState
extends State


func _enter_state()->void:
	var menu_machine: MenuStateMachine=self.machine as MenuStateMachine
	
	for l: List2D in menu_machine.final_positions:
		l.position=Vector2(-500,-500)
		for c: Node in l.get_children():
			if c is Button:
				c.disabled=true
	
	menu_machine.new_list.position=menu_machine.final_positions[menu_machine.new_list]
	for c: Node in menu_machine.new_list.get_children():
		if c is Button:
			c.disabled=false
	
