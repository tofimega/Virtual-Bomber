class_name GameScene
extends Node2D


var score: PackedScene=preload("res://scenes/UI/score_counter/score_counter_panel.tscn")


func _ready()->void:
	print("17: game scene loaded")
	if get_tree().get_first_node_in_group("left_panel").get_children().size()==0 or not get_tree().get_first_node_in_group("left_panel").get_children()[0] is ScorePanel:
		SceneControl.scene_replaced.connect(set_score_counters)
		SceneControl.replace_left_scene(score)
		SceneControl.replace_right_scene(score)
		
func set_score_counters(panel: Node,parent: Node)->void:
	if not panel is ScorePanel: return
	if parent==get_tree().get_first_node_in_group("left_panel"):
		panel.top_counter.id=GlobalAccess.PLAYER_ID.P1
		panel.bottom_counter.id=GlobalAccess.PLAYER_ID.P3
	
	elif parent==get_tree().get_first_node_in_group("right_panel"):
		panel.top_counter.id=GlobalAccess.PLAYER_ID.P2
		panel.bottom_counter.id=GlobalAccess.PLAYER_ID.P4
