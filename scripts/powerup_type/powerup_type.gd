class_name PowerupType
extends Resource

@export var graphics: SpriteFrames= ResourceLoader.load("res://assets/resources/spriteframes/powerup/default_powerup.tres")


func apply_effect(player: Player)->void:
	print("wow effect~")
