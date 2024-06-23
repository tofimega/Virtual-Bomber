class_name EnemySpawn
extends Marker2D


var enemy_type: BaseEnemy

func _init(enemy_type: BaseEnemy)->void:
	self.enemy_type=enemy_type
