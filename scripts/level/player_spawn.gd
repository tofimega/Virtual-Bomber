class_name PlayerSpawn
extends Marker2D


func _ready():
	print("ok")
	SignalBus.player_spawn_ready.emit(self)
