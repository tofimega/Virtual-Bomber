class_name Screen
extends Control


@onready var left = $MarginContainer/HBoxContainer/Left
@onready var game_screen = $MarginContainer/HBoxContainer/SubViewportContainer/GameScreen
@onready var right = $MarginContainer/HBoxContainer/Right

var starting_scene: PackedScene=preload("res://scenes/main/game_scene.tscn")

func _ready()->void:
	
	if starting_scene!=null:
		#var scene=starting_scene.instantiate()
		GlobalAccess.replace_game_scene(starting_scene)
	
	
