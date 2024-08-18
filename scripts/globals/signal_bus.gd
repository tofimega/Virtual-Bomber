extends Node

#region level loading stuff
signal player_spawn_ready(spawm_point: PlayerSpawn)
signal level_loaded
signal enemy_spawn_ready(spawn_point: EnemySpawn)
#endregion

#region game settings stuff
signal request_add_player
signal request_remove_player(player: GlobalAccess.PLAYER_ID)
#endregion


#region game flow
signal start_new_round
signal new_round

signal bomb_placed(bomb: Bomb)
signal bomb_exploded(bomb: Bomb)
signal player_placing_bomb(bomb: Bomb)


signal new_explosion_on_field()
signal explosion_dissipated()

signal player_ready(p: Player)
signal player_dead(p: Player)

signal player_capacity_up(id: GlobalAccess.PLAYER_ID)
signal player_range_up(id: GlobalAccess.PLAYER_ID)
#endregion

#region scoring
signal player_data_changed(id: GlobalAccess.PLAYER_ID)
signal player_killed_player(killer: GlobalAccess.PLAYER_ID, victim: GlobalAccess.PLAYER_ID)
signal player_killed_enemy(killer: GlobalAccess.PLAYER_ID)
#endregion


func emit_level_loaded()->void:
	level_loaded.emit()
