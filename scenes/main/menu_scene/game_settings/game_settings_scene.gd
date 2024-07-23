class_name GameSettingsScene
extends Control

@onready var player_select: PlayerSelect = $MarginContainer/VBoxContainer/PlayerSelect
@onready var game_mode_selection: GameModeSelect = $MarginContainer/VBoxContainer/HBoxContainer/GameModeSelection
@onready var level_selection: LevelSelect = $MarginContainer/VBoxContainer/HBoxContainer/LevelSelection
@onready var back_to_menu: Button = $MarginContainer/VBoxContainer/HBoxContainer2/BackToMenu
@onready var start_game: Button = $MarginContainer/VBoxContainer/HBoxContainer2/StartGame

var game_settings: GameSettings=GameSettings.new()

func _ready():
	start_game.pressed.connect(switch_to_game)
	back_to_menu.pressed.connect(switch_to_menu)

func update_player_data()->void:
	for p: PlayerData in game_settings.player_data:
		p.free()
	
	game_settings.player_data.clear()
	
	var i: int=0
	for c: Node in player_select.player_tags.get_children():
		if c is PlayerSelectTag:
			var new_data: PlayerData=PlayerData.new()
			new_data.id=i
			if !c.player_name.text.is_empty():
				new_data.name=c.player_name.text
			game_settings.player_data.append(new_data)
			i+=1

func update_game_mode_data()->void:
	GlobalAccess.games_to_win=game_mode_selection.wins

func update_level_data()->void:
	#game_settings.level_data=level_selection.current_selection
	GlobalAccess.level_to_load=level_selection.current_selection

func switch_to_game()->void:
	
	update_player_data()
	update_level_data()
	update_game_mode_data()
	
	if player_select.player_count<2: return
	if player_select.player_count>4: return
	
	#TODO: redo this once LevelData is created
	if GlobalAccess.level_to_load == null: return
	if GlobalAccess.level_to_load=="": return
	if not FileAccess.file_exists(GlobalAccess.level_to_load): return
	
	if game_mode_selection.wins<1: return
	

	GlobalAccess.game_settings=game_settings
		
	
	SceneControl.replace_game_scene(ResourceLoader.load("res://scenes/main/game_scene/game_scene.tscn"))

func switch_to_menu()->void:
	SceneControl.replace_game_scene(ResourceLoader.load("res://scenes/main/menu_scene/menu_scene.tscn"))
