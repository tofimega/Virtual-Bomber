class_name GhostEnemy
extends BaseEnemy


@onready var pass_box = $PassBox
@onready var state_machine = $StateMachine


func _ready()->void:
	super()
	#TODO: fix this
	pass_box.body_entered.connect(switch_to_pts)
	pass_box.body_exited.connect(switch_to_ns)
	speed=50


func _process(delta):
	pass

func switch_to_pts(_b)->void:
	state_machine.switch_state(state_machine.states[1])
	
func switch_to_ns(_b)->void:
	state_machine.switch_state(state_machine.states[0])
