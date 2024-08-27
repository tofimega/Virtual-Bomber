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
	SignalBus.player_settings_changed.connect(update_player_data)
	SignalBus.player_added.connect(update_player_data)
	SignalBus.player_removed.connect(update_player_data)
	SignalBus.request_validate_gamemode.connect(update_game_mode_data)
	SignalBus.request_validate_level.connect(update_level_data)

func update_player_data(id: GlobalAccess.PlayerID)->void:
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
func update_game_mode_data(new_mode: GameMode)->void:
	print("7: updating game mode: "+str(game_settings.rounds))
	game_settings.rounds=game_mode_selection.wins
	game_settings.game_mode=new_mode
	
	if !new_mode.is_level_compatible(game_settings.level_data): # ALERT: placeholder obviously
		level_selection.current_selection=""
		game_settings.level_data=""
	print("game mode updated: "+str(game_settings.rounds))

func update_level_data(new_data: String)->void:
	print("6: updating level: "+GlobalAccess.level_to_load)
	if game_settings.game_mode.is_level_compatible(new_data):
		game_settings.level_data=new_data
		level_selection.current_selection=new_data
	else:
		OS.alert("Level not compatible with current game mode!")
	print("level updated: "+GlobalAccess.level_to_load)
func switch_to_game()->void:
	print("1: start")
	print("8: game settings updated")
	if player_select.player_count<2: return
	print("9: player count >=2")
	if player_select.player_count>4: return
	print("10: playercount <=4")
	#TODO: redo this once LevelData is created
	if game_settings.level_data == null: 
		OS.alert("No level selected","Cannot start game")
		return
	print("11: level path exists: "+GlobalAccess.level_to_load)
	if game_settings.level_data=="": 
		OS.alert("No level selected","Cannot start game")
		return
	print("12: level path is not empty: "+GlobalAccess.level_to_load)
	if not FileAccess.file_exists(game_settings.level_data): 
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
