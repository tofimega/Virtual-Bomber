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
	if player_tags.player_count<2: return
	if player_tags.player_count>4: return
	
	#TODO: redo this once LevelData is created
	if GlobalAccess.level_to_load == null: return
	if GlobalAccess.level_to_load=="": return
	if not FileAccess.file_exists(GlobalAccess.level_to_load): return
	
	if game_mode_selection.wins<1: return
	
	GlobalAccess.player_data.clear()
	for i:int in player_tags.player_count:
		var data: PlayerData=PlayerData.new()
		data.id=i
		GlobalAccess.player_data.append(data)
		
		
	GlobalAccess.games_to_win=game_mode_selection.wins
	SceneControl.replace_game_scene(ResourceLoader.load("res://scenes/main/game_scene/game_scene.tscn"))

func switch_to_menu()->void:
	SceneControl.replace_game_scene(ResourceLoader.load("res://scenes/main/menu_scene/menu_scene.tscn"))
