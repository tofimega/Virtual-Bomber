extends Node

#region level loading stuff
signal player_spawn_ready(spawm_point: PlayerSpawn)
signal level_loaded
signal enemy_spawn_ready(spawn_point: EnemySpawn)
#endregion

#region game settings stuff
signal request_add_player
signal request_remove_player(player: GlobalAccess.PlayerID)
#endregion


#region game flow
signal start_new_round
signal new_round
signal round_over(status: GameMode.RoundStatus)


signal bomb_placed(bomb: Bomb)
signal bomb_exploded(bomb: Bomb)
signal player_placing_bomb(bomb: Bomb)


signal new_explosion_on_field()
signal explosion_dissipated()

signal player_ready(p: Player)
signal player_dead(p: GlobalAccess.PlayerID)

signal player_capacity_up(id: GlobalAccess.PlayerID)
signal player_range_up(id: GlobalAccess.PlayerID)
#endregion

#region scoring
signal player_data_changed(id: GlobalAccess.PlayerID)
signal player_killed_player(killer: GlobalAccess.PlayerID, victim: GlobalAccess.PlayerID)
signal player_killed_enemy(killer: GlobalAccess.PlayerID)
#endregion
