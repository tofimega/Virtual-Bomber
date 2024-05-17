class_name PlayerSpawn
extends Marker2D


func _ready():
	SignalBus.player_spawn_ready.emit(self)
