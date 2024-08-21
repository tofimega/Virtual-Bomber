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
	game_settings.player_count=0
	print("2: updating player data: "+str(game_settings.player_data))
	game_settings.player_data.clear()
	print("3: old data clear: "+str(game_settings.player_data))
	var i: int=0
	for c: Node in player_select.player_tags.get_children():
		if c is PlayerSelectTag:
			game_settings.get_player_data(i)
			if !c.player_name.text.is_empty():
				game_settings.get_player_data(i).name=c.player_name.text
			i+=1
			game_settings.player_count+=1
	print("4: new data in: "+str(game_settings.player_data))
func update_game_mode_data()->void:
	print("7: updating game mode: "+str(game_settings.rounds))
	game_settings.rounds=game_mode_selection.wins
	game_settings.game_mode=game_mode_selection.game_mode
	print("game mode updated: "+str(GlobalAccess.games_to_win))

func update_level_data()->void:
	print("6: updating level: "+GlobalAccess.level_to_load)
	#game_settings.level_data=level_selection.current_selection
	GlobalAccess.level_to_load=level_selection.current_selection
	print("level updated: "+GlobalAccess.level_to_load)
func switch_to_game()->void:
	print("1: start")
	update_player_data()
	update_level_data()
	update_game_mode_data()
	print("8: game settings updated")
	if player_select.player_count<2: return
	print("9: player count >=2")
	if player_select.player_count>4: return
	print("10: playercount <=4")
	#TODO: redo this once LevelData is created
	if GlobalAccess.level_to_load == null: 
		OS.alert("No level selected","Cannot start game")
		return
	print("11: level path exists: "+GlobalAccess.level_to_load)
	if GlobalAccess.level_to_load=="": 
		OS.alert("No level selected","Cannot start game")
		return
	print("12: level path is not empty: "+GlobalAccess.level_to_load)
	if not FileAccess.file_exists(GlobalAccess.level_to_load): 
		OS.alert("No level selected","Cannot start game")
		return
	print("13: level path is valid file:\n"+FileAccess.get_file_as_string(GlobalAccess.level_to_load))
	if game_mode_selection.wins<1: return
	print("14: rounds >=1")

	GlobalAccess.game_settings=game_settings
	print("15: game settings saved")
	
	SceneControl.replace_game_scene(ResourceLoader.load("res://scenes/main/game_scene/game_scene.tscn"))
	print("16: loading game scene")
func switch_to_menu()->void:
	SceneControl.replace_game_scene(ResourceLoader.load("res://scenes/main/menu_scene/menu_scene.tscn"))
