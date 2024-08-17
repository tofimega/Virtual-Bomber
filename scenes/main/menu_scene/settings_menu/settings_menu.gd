class_name SettingsMenu
extends Control

@onready var filter_select: OptionButton = $MarginContainer/Categories/Graphics/VBoxContainer/GridContainer/FilterSelect
@onready var scaling_select: OptionButton = $MarginContainer/Categories/Graphics/VBoxContainer/GridContainer/ScalingSelect
@onready var scale_select: SpinBox = $MarginContainer/Categories/Graphics/VBoxContainer/GridContainer/ScaleSelect

func _ready() -> void:
	init_values()
	filter_select.item_selected.connect(change_filter)
	scaling_select.item_selected.connect(change_scale_mode)
	scale_select.value_changed.connect(change_scale)


func load_fresh_settings()->void:
	Settings.save_data()
	Settings.load_data(Settings.SETTINGS_PATH)

func change_scale_mode(value: int)->void:
	match value: 
		1: 
			Settings.settings_file.scale_mode==1
			Settings.settings_file.scale==floor(Settings.settings_file.scale)
			scale_select.set_value_no_signal(floor(Settings.settings_file.scale))
		0: Settings.settings_file.scale_mode==0
		
	load_fresh_settings()
func change_scale(value: float)->void:
	if Settings.settings_file.scale_mode==1:
		value=floor(value)
		scale_select.set_value_no_signal(value)
	Settings.settings_file.scale=value
	load_fresh_settings()

func change_filter(value: int)->void:
	Settings.settings_file.filter=value
	load_fresh_settings()

func init_values()->void:
	Settings.load_data(Settings.SETTINGS_PATH)
	if Settings.settings_file.scale_mode==1:
		Settings.settings_file.scale=floor(Settings.settings_file.scale)
	scale_select.set_value_no_signal(Settings.settings_file.scale)
	
	filter_select.select((Settings.settings_file.filter+1)%2)

	match Settings.settings_file.scale_mode:
		1: scaling_select.select(1)
		0: scaling_select.select(0)
	


func _on_back_to_menu_pressed() -> void:
	SceneControl.replace_game_scene(ResourceLoader.load("res://scenes/main/menu_scene/menu_scene.tscn"))
