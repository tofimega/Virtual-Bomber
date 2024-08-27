class_name ScorePanel
extends Control

@onready var top_counter: ScoreCounter = $VBoxContainer/ScoreCounter
@onready var bottom_counter: ScoreCounter = $VBoxContainer/ScoreCounter2


func _ready()->void:
	var base: GlobalAccess.PlayerID=GlobalAccess.PlayerID.P1 if get_parent()==SceneControl.get_left_panel() else GlobalAccess.PlayerID.P2
	top_counter.id=base as GlobalAccess.PlayerID
	bottom_counter.id=base+2 as GlobalAccess.PlayerID
