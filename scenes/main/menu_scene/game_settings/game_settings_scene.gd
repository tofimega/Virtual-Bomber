class_name GameSettingsScene
extends Control

@onready var player_tags: PlayerSelect = $MarginContainer/VBoxContainer/PlayerSelect
@onready var game_mode_selection: GameModeSelect = $MarginContainer/VBoxContainer/HBoxContainer/GameModeSelection
@onready var level_selection = $MarginContainer/VBoxContainer/HBoxContainer/LevelSelection
@onready var back_to_menu: Button = $MarginContainer/VBoxContainer/HBoxContainer2/BackToMenu
@onready var start_game: Button = $MarginContainer/VBoxContainer/HBoxContainer2/StartGame



func _ready():
	start_game.pressed.connect(switch_to_game)
	back_to_menu.pressed.connect(switch_to_menu)
	
func switch_to_game()->void:
	GlobalAccess.player_data.clear()
	for i:int in player_tags.player_count:
		var data: PlayerData=PlayerData.new()
		data.id=i
		GlobalAccess.player_data.append(data)
		
		
	GlobalAccess.games_to_win=game_mode_selection.wins
	GlobalAccess.replace_game_scene(ResourceLoader.load("res://scenes/main/game_scene/game_scene.tscn"))

func switch_to_menu()->void:
	GlobalAccess.replace_game_scene(ResourceLoader.load("res://scenes/main/menu_scene/menu_scene.tscn"))
