class_name Crate
extends Tile

@onready var animated_sprite_2d = $AnimatedSprite2D




func _on_area_2d_area_entered(area):
	animated_sprite_2d.play("breaking")
	
	

func drop_item()->void:
	print("yeowch")
	if randi()%5<3:
		var powerup: Powerup
		if randi()%2==0:
			powerup=ResourceLoader.load("res://scenes/actors/powerup/range/range_powerup.tscn").instantiate()
		else:
			powerup=ResourceLoader.load("res://scenes/actors/powerup/capacity/capacity_powerup.tscn").instantiate()
		
		
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
