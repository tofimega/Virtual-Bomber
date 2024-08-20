class_name SettingsMenu
extends Control

@onready var filter_select: OptionButton = $MarginContainer/Categories/Graphics/VBoxContainer/GridContainer/FilterSelect
@onready var scaling_select: OptionButton = $MarginContainer/Categories/Graphics/VBoxContainer/GridContainer/ScalingSelect
@onready var window_mode_select: OptionButton = $MarginContainer/Categories/Graphics/VBoxContainer/GridContainer/WindowModeSelect

func _ready() -> void:
	var texture_preview: Sprite2D=Sprite2D.new()
	texture_preview.texture=preload("res://assets/images/tiles/wall tile.png")
	texture_preview.position.y+=200
	SceneControl.get_left_panel().add_child(texture_preview)
	
	init_values()
	filter_select.item_selected.connect(change_filter)
	scaling_select.item_selected.connect(change_scale_mode)
	window_mode_select.item_selected.connect(change_window_mode)


func load_fresh_settings()->void:
	Settings.apply_data()
	Settings.save_data()
	print_status()

func change_scale_mode(value: int)->void:
	Settings.settings_file.scale_mode=value
	load_fresh_settings()


func change_filter(value: int)->void:
	Settings.settings_file.filter=value
	load_fresh_settings()

func change_window_mode(value: int)->void:
	Settings.settings_file.window_mode=value*4
	load_fresh_settings()

func init_values()->void:
	Settings.load_data(Settings.SETTINGS_PATH)
	
	filter_select.select(Settings.settings_file.filter)

	scaling_select.select(Settings.settings_file.scale_mode)
	
	window_mode_select.select(Settings.settings_file.window_mode/4)
	
	print_status()
	
func print_status()->void:
	print("(In Menu)\n"+"filter="+str(filter_select.selected)+\
	"\nscaling mode="+str(scaling_select.selected)\
	+ "\nwindow mode="+str(window_mode_select.selected))

func _on_back_to_menu_pressed() -> void:
	for n in SceneControl.get_left_panel().get_children():
		n.free()
	SceneControl.replace_game_scene(ResourceLoader.load("res://scenes/main/menu_scene/menu_scene.tscn"))
