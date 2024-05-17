extends Node2D


func _ready():
	SignalBus.level_loaded.emit()
