extends AnimatedSprite2D

@onready var timer = $Timer

@export var frames: SpriteFrames= ResourceLoader.load("res://assets/resources/spriteframes/powerup/default_powerup.tres")
var cooldown: float=0.6

func _ready()->void:
	sprite_frames=frames


func _on_timer_timeout():
	play("default")


func _on_animation_finished():
	set_frame_and_progress(0,0)
	timer.start(cooldown)
