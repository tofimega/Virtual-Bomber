class_name GameScene
extends Node2D


var score: PackedScene=preload("res://scenes/UI/score_counter/score_counter_panel.tscn")


func _ready()->void:
	GlobalAccess.replace_left_scene(score)
	GlobalAccess.replace_right_scene(score)
