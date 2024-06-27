extends Node


signal player_spawn_ready(spawm_point: PlayerSpawn)
signal level_loaded

signal bomb_placed(bomb: Bomb)
signal bomb_exploded(bomb: Bomb)
signal player_placing_bomb(bomb: Bomb)


signal new_explosion_on_field()
signal explosion_dissipated()

signal player_ready(p: Player)
signal player_dead(p: Player)

signal enemy_spawn_ready(spawn_point: EnemySpawn)

var count: int=0
func emit_level_loaded()->void:
	count+=1
	print(count)
	level_loaded.emit()
