class_name ScoreCounter
extends Control
@onready var player_name: Label = $PlayerName
@onready var player_icon: TextureRect = $PlayerIcon
@onready var range: Label = $Stastistics/Range
@onready var enemies_killed: Label = $Stastistics/EnemiesKilled
@onready var capacity: Label = $Stastistics/Capacity
@onready var deaths: Label = $Stastistics/Deaths
@onready var bomb_count: Label = $Stastistics/BombCount
@onready var players_killed: Label = $Stastistics/PlayersKilled
@onready var score: Label = $Score

var id: GlobalAccess.PLAYER_ID

func _ready()->void:
	SignalBus.player_data_changed.connect(update_data)
	
func update_data(id):
	if id==self.id:
		var d: PlayerData=GlobalAccess.player_data[id]
		player_name.text=d.name
		score.text=str(d.points)
		player_icon.texture=d.icon
		
		range.text="r: "+str(d.range)
		capacity.text="c: "+str(d.capacity)
		enemies_killed.text="e: "+str(d.enemies_killed)
		deaths.text="x: "+str(d.deaths)
		players_killed.text="p: "+str(d.players_killed)
		bomb_count.text="b: "+str(d.bomb_count)
		
		if d.bomb_count>=d.capacity:
			bomb_count.add_theme_color_override("font_color",Color(1,0,0,1))
		else: bomb_count.remove_theme_color_override("font_color")
