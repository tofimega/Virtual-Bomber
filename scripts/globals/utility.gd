extends Node

const FPS_MAX: int =60

func _ready():
	Engine.max_fps=FPS_MAX

func get_frame_rate_deviance(delta):
	return delta*(FPS_MAX)
