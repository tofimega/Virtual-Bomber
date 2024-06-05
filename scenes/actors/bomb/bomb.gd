class_name Bomb
extends StaticBody2D

@onready var timer = $Timer as Timer

@export var countdown: float= 4


@onready var exploder = $Exploder as Area2D


var player: Player

func _ready():

	timer.timeout.connect(explode)
	exploder.area_entered.connect(explode)
	timer.start(countdown)
	
	SignalBus.bomb_placed.emit(self)
	

func explode()->void:
	print("boom")
	timer.stop()
	#spawn starter explosion
	var explosion: Explosion=ResourceLoader.load("res://scenes/actors/bomb/explosion/explosion.tscn").instantiate()
	explosion.raw_power=player.power
	explosion.true_power=player.power
	explosion.position=Vector2(position)
	explosion.direction=Explosion.SpreadDirection.SOURCE
	GlobalAccess.get_actor_container().add_child.call_deferred(explosion)
	
	SignalBus.bomb_exploded.emit(self)
	queue_free()
	
	
