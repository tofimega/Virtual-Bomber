class_name MenuStillState
extends State


func _enter_state()->void:
	var machine: MenuStateMachine=self.machine as MenuStateMachine
	
	for l: List2D in machine.final_positions:
		l.position=Vector2(-500,-500)
		for c: Node in l.get_children():
			if c is Button:
				c.disabled=true
	
	machine.new_list.position=machine.final_positions[machine.new_list]
	for c: Node in machine.new_list.get_children():
		if c is Button:
			c.disabled=false
	
