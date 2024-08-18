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
	ProjectSettings.set_setting("rendering/textures/canvas_textures/default_texture_filter", settings_file.filter)
	ProjectSettings.set_setting("display/window/stretch/scale_mode", settings_file.scale_to_string[settings_file.scale_mode])
	#if ProjectSettings.get_setting("display/window/s"): 
	#	pass # TODO: if scaling up: resize window if new scale is bigger than window, the other way when scaling down


func load_data(path: String)->void:
	settings_file=ResourceLoader.load(path)
	apply_data()
func save_data()->void:
	ResourceSaver.save(settings_file,SETTINGS_PATH)
	print("Data Saved:\n"+"Filter: "+str(settings_file.filter)+" (in PS: "+	str(ProjectSettings.get_setting("rendering/textures/canvas_textures/default_texture_filter"))+")\n"\
			+ "Scale Mode: "+str(settings_file.scale_mode)+" (in PS: "+	str(ProjectSettings.get_setting("display/window/stretch/scale_mode"))+")")
			
