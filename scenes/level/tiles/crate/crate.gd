class_name Crate
extends Tile

@onready var animated_sprite_2d = $AnimatedSprite2D




func _on_area_2d_area_entered(area):
	animated_sprite_2d.play("breaking")
	
	

func drop_item()->void:
	print("yeowch")


func _on_animated_sprite_2d_animation_finished():
	if animated_sprite_2d.animation=="breaking":
		queue_free()


func _on_animated_sprite_2d_frame_changed():
	if animated_sprite_2d.frame==20:
		drop_item()
		collision_layer=0
