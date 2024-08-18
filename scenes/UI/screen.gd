class_name Screen
extends Control


@onready var left = $MarginContainer/HBoxContainer/Left
@onready var game_screen = $MarginContainer/HBoxContainer/SubViewportContainer/GameScreen
@onready var right = $MarginContainer/HBoxContainer/Right


var starting_scene: PackedScene=preload("res://scenes/main/menu_scene/menu_scene.tscn")
func _ready()->void:
	apply_graphics_settings()
	Settings.settings_changed.connect(apply_graphics_settings)
	
	if starting_scene!=null:
		SceneControl.replace_game_scene(starting_scene)
	

func apply_graphics_settings()->void:
	game_screen.canvas_item_default_texture_filter=Settings.settings_file.filter
	get_tree().get_root().canvas_item_default_texture_filter=Settings.settings_file.filter
	print("transform: ",get_tree().get_root().canvas_transform)
