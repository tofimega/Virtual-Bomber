class_name GhostEnemy
extends BaseEnemy


@onready var pass_box = $PassBox



func _ready()->void:
	super()

	speed=50

var force_turn=false
func choose_direction()->void:
	if (!pass_box.has_overlapping_bodies()	&& !pass_box.has_overlapping_areas()) || force_turn:
		super()
func _physics_process(delta):
	
	velocity.x=current_dir.x*speed
	velocity.y=current_dir.y*speed
	
	force_turn=move_and_slide()
	
	if force_turn:
		turn()


