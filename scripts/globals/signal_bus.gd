extends Node


signal player_spawn_ready(spawm_point: PlayerSpawn)
signal level_loaded

signal bomb_placed(bomb)
signal bomb_exploded(bomb)

signal new_explosion_on_field()
signal explosion_dissipated()

signal player_ready(p: Player)
signal player_dead(p: Player)


func emit_level_loaded()->void:
	level_loaded.emit()
