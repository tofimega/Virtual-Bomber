class_name LevelSelect
extends Panel

@onready var level_buttons: VBoxContainer = $MarginContainer/HBoxContainer/VBoxContainer/ScrollContainer/LevelButtons

@onready var custom_level_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/CustomLevelButton





var current_selection: String=""

func _ready():
	for b: Node in level_buttons.get_children():
		if b is LevelButton:
			b.pressed.connect(func(): SignalBus.request_validate_level.emit(b.level_data))
	
	custom_level_button.pressed.connect(get_level_from_user)



func get_level_from_user()->void:
	var file_dialog:FileDialog=FileDialog.new()
	file_dialog.size=Vector2(700,500)
	file_dialog.title="Select Level"
	file_dialog.mode_overrides_title=false
	file_dialog.file_mode=FileDialog.FILE_MODE_OPEN_FILE
	file_dialog.access=FileDialog.ACCESS_FILESYSTEM
	file_dialog.initial_position=Window.WINDOW_INITIAL_POSITION_CENTER_SCREEN_WITH_MOUSE_FOCUS
	file_dialog.file_selected.connect(
		func(path: String):
			print(path)
			SignalBus.request_validate_level.emit(path)
			
			)
	get_tree().get_root().add_child(file_dialog)
	file_dialog.show()
