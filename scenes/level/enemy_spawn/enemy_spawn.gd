class_name EnemySpawn
extends Marker2D


var enemy_type: PackedScene

func _init(set_enemy_type: PackedScene)->void:
	self.enemy_type=set_enemy_type

func _ready() -> void:
	SignalBus.enemy_spawn_ready.emit(self)
