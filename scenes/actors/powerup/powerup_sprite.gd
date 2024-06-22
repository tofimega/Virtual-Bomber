extends AnimatedSprite2D

@onready var timer = $Timer
var cooldown: float=0.6

func _on_timer_timeout():
	play("default")


func _on_animation_finished():
	timer.start(cooldown)

