extends Node


signal settings_changed


var settings_file:SettingsData=SettingsData.new()

const SETTINGS_PATH: String="user://settings.tres"


func _ready():
	if !FileAccess.file_exists("user://settings.tres"):
		settings_file=SettingsData.new()
		save_data()
	else:
		load_data(SETTINGS_PATH)


func apply_data()->void:
	if settings_file == null:
		pass
	
	get_window().canvas_item_default_texture_filter=settings_file.filter
	SceneControl.get_main_viewport().canvas_item_default_texture_filter=settings_file.filter
	
	get_window().content_scale_stretch=settings_file.scale_mode
	DisplayServer.window_set_mode(settings_file.window_mode)

func load_data(path: String)->void:
	settings_file=ResourceLoader.load(path)
	apply_data()

func save_data()->void:
	ResourceSaver.save(settings_file,SETTINGS_PATH)
	print("Data Saved:\n"+"Filter: "+str(settings_file.filter)\
		+ "Scale Mode: "+str(settings_file.scale_mode)\
		+ "Window Mode: "+str(settings_file.window_mode))
