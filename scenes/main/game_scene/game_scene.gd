class_name GameScene
extends Node2D


var score: PackedScene=preload("res://scenes/UI/score_counter/score_counter_panel.tscn")


func _ready()->void:
	print("17: game scene loaded")
	if get_tree().get_first_node_in_group("left_panel").get_children().size()==0 or not get_tree().get_first_node_in_group("left_panel").get_children()[0] is ScorePanel:
		SceneControl.replace_left_scene(score)
		SceneControl.replace_right_scene(score)
