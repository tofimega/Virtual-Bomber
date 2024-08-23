class_name LevelButton
extends Button

@export var level_name: String

@export var level_data: String


func _ready() -> void:
	text=level_name
