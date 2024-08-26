class_name Bomb
extends StaticBody2D

@onready var timer = $Timer as Timer

@export var countdown: float= 4

@onready var collision_shape = $CollisionShape2D


var player: PlayerData



func _ready():
	SignalBus.player_placing_bomb.emit(self)
	timer.timeout.connect(explode)
	timer.start(countdown)
	
	SignalBus.bomb_placed.emit(self)


func explode()->void:
	print("boom")
	timer.stop()
	#spawn starter explosion
	var explosion: Explosion=preload("res://scenes/actors/bomb/explosion/explosion.tscn").instantiate()
	explosion.raw_power=player.explosion_range
	explosion.true_power=player.explosion_range
	explosion.player=player
	explosion.position=Vector2(position)
	explosion.direction=Explosion.SpreadDirection.SOURCE
	GlobalAccess.get_actor_container().add_child.call_deferred(explosion)
	
	SignalBus.bomb_exploded.emit(self)
	queue_free()
	
	
