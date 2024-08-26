class_name Powerup
extends Area2D

@onready var powerup_sprite: AnimatedSprite2D = $PowerupSprite

@export var effect: PowerupType=PowerupType.new()

func _ready()->void:
	powerup_sprite.sprite_frames=effect.graphics

func _apply_powerup(player: Player)->void:
	effect.apply_effect(player)
	print("applying powerup")


func _on_body_entered(body: Player):
	_apply_powerup(body)
	queue_free()
