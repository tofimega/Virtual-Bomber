class_name Crate
extends Tile

@onready var animated_sprite_2d = $AnimatedSprite2D



static var powerup_types: Array[PowerupType]=[]


static func _static_init() -> void:
	for fn: String in DirAccess.get_files_at("res://assets/resources/powerup_effect"):
		var res: Resource=ResourceLoader.load("res://assets/resources/powerup_effect/"+fn)
		if res is PowerupType:
			powerup_types.append(res)

func _on_area_2d_area_entered(area):
	animated_sprite_2d.play("breaking")
	
	

func drop_item()->void:
	print("yeowch")
	if randi()%5<3:
		var powerup: Powerup= ResourceLoader.load("res://scenes/actors/powerup/powerup.tscn").instantiate()
		
		powerup.effect=powerup_types[randi()%powerup_types.size()]
		powerup.position.x=position.x
		powerup.position.y=position.y
	
		GlobalAccess.get_actor_container().add_child.call_deferred(powerup)
	
	

func _on_animated_sprite_2d_animation_finished():
	if animated_sprite_2d.animation=="breaking":
		queue_free()


func _on_animated_sprite_2d_frame_changed():
	if animated_sprite_2d.frame==20:
		drop_item()
		collision_layer=0
