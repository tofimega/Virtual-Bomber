class_name GhostEnemyPassthroughState
extends GhostEnemyState




func _state_process(delta)->void:
	target.velocity.x=target.current_dir.x*target.speed
	target.velocity.y=target.current_dir.y*target.speed
	
	var b: bool=target.move_and_slide()
	
	if b:
		target.current_dir=-target.current_dir
