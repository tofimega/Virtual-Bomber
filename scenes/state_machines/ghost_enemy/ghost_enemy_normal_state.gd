class_name GhostEnemyNormalState
extends GhostEnemyState

func enter_state()->void:
	target.turn()
func exit_state()->void:
	target.timer.stop()

func _state_process(delta)->void:
	target.velocity.x=target.current_dir.x*target.speed
	target.velocity.y=target.current_dir.y*target.speed
	
	var b: bool=target.move_and_slide()
	
	if b:
		target.turn()
