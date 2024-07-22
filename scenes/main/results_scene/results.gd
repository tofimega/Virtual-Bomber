class_name ResultsScene
extends Control

@onready var label = $VBoxContainer/Label
@onready var new_game = $VBoxContainer/HBoxContainer/NewGame
@onready var menu = $VBoxContainer/HBoxContainer/Menu

func _ready()->void:
	label.text="GAME OVER\nWinner is Player "+str(GlobalAccess.get_winner())
	new_game.pressed.connect(start_new_game)
	menu.pressed.connect(back_to_menu)



func start_new_game()->void:
	
	for n in GlobalAccess.get_left_panel().get_children():
		n.free()
	for n in GlobalAccess.get_right_panel().get_children():
		n.free()
	SceneControl.replace_game_scene(ResourceLoader.load("res://scenes/main/menu_scene/game_settings/game_settings_scene.tscn"))


func back_to_menu()->void:
	for n in GlobalAccess.get_left_panel().get_children():
		n.free()
	for n in GlobalAccess.get_right_panel().get_children():
		n.free()
	SceneControl.replace_game_scene(ResourceLoader.load("res://scenes/main/menu_scene/menu_scene.tscn"))
