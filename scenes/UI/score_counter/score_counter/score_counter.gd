class_name ScoreCounter
extends Control

@onready var player_name: Label = $PlayerName
@onready var player_icon: TextureRect = $PlayerIcon
@onready var explosion_range: Counter = $Stastistics/Range
@onready var enemies_killed: Counter = $Stastistics/EnemiesKilled
@onready var capacity: Counter = $Stastistics/Capacity
@onready var deaths: Counter = $Stastistics/Deaths
@onready var bomb_count: Counter = $Stastistics/BombCount
@onready var players_killed: Counter = $Stastistics/PlayersKilled
@onready var score: Label = $Score

var id: GlobalAccess.PlayerID:
	set(a):
		id=a
		if id>=GlobalAccess.game_settings.player_data.size():
			modulate=Color(0.5,0.5,0.5,0.8)
		else:
			modulate=Color(1,1,1,1)

func _ready()->void:
	SignalBus.player_data_changed.connect(update_data)
func update_data(id_to_update):
	if id_to_update==self.id:
		var d: PlayerData=GlobalAccess.game_settings.get_player_data(id_to_update)
		player_name.text=d.name
		score.text=str(d.points)
		player_icon.texture=d.icon
		
		explosion_range.label.text=str(d.explosion_range)
		capacity.label.text=str(d.capacity)
		enemies_killed.label.text=str(d.enemies_killed)
		deaths.label.text=str(d.deaths)
		players_killed.label.text=str(d.players_killed)
		bomb_count.label.text=str(d.bomb_count)
		
		if d.bomb_count>=d.capacity:
			bomb_count.label.add_theme_color_override("font_color",Color(1,0,0,1))
		else: bomb_count.label.remove_theme_color_override("font_color")
