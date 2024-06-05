class_name Bomb
extends StaticBody2D

@onready var timer = $Timer as Timer

@export var countdown: float= 4


@onready var exploder = $Exploder as Area2D


func _ready():

	timer.timeout.connect(explode)
	exploder.area_entered.connect(explode)
	timer.start(countdown)
	
	SignalBus.bomb_placed.emit(self)
	

func explode()->void:
	print("boom")
	timer.stop()
	#spawn starter explosion
	SignalBus.bomb_exploded.emit(self)
	queue_free()
	
	
