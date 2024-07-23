class_name LevelSelect
extends Panel

@onready var level_buttons: VBoxContainer = $MarginContainer/HBoxContainer/VBoxContainer/ScrollContainer/LevelButtons

@onready var custom_level_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/CustomLevelButton


#TODO: replace with something more generic
@onready var level_1_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/ScrollContainer/LevelButtons/Level1Button
@onready var level_2_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/ScrollContainer/LevelButtons/Level2Button
@onready var level_2_button_2 = $MarginContainer/HBoxContainer/VBoxContainer/ScrollContainer/LevelButtons/Level2Button2


var current_selection: String=""

func _ready():
	level_1_button.pressed.connect(func():current_selection="res://spriteTest.txt")
	level_2_button.pressed.connect(func():current_selection="res://test3.txt")
	level_2_button_2.pressed.connect(func():current_selection="res://assets/levels/1.txt")
	custom_level_button.pressed.connect(get_level_from_user)


func get_level_from_user()->void:
	var file_dialog:FileDialog=FileDialog.new()
	file_dialog.size=Vector2(700,500)
	file_dialog.title="Select Level"
	file_dialog.mode_overrides_title=false
	file_dialog.file_mode=FileDialog.FILE_MODE_OPEN_FILE
	file_dialog.access=FileDialog.ACCESS_FILESYSTEM
	file_dialog.initial_position=Window.WINDOW_INITIAL_POSITION_CENTER_SCREEN_WITH_MOUSE_FOCUS
	file_dialog.confirmed.connect(
	func():
		GlobalAccess.level_to_load=file_dialog.current_path
		print(file_dialog.current_path)
		file_dialog.queue_free()
	)
	get_tree().get_root().add_child(file_dialog)
	file_dialog.show()
