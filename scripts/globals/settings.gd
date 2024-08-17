extends Node

var settings_file:SettingsData=SettingsData.new()

const SETTINGS_PATH: String="user://settings.tres"


func _ready():
	if !FileAccess.file_exists("user://settings.tres"):
		settings_file=SettingsData.new()
		save_data()
	else:
		load_data(SETTINGS_PATH)


func load_data(path: String)->void:
	settings_file=ResourceLoader.load(path)
	ProjectSettings.set_setting("rendering/textures/canvas_textures/default_texture_filter", settings_file.filter)
	ProjectSettings.set_setting("display/window/stretch/scale_mode", settings_file.scale_mode)
	if settings_file.scale_mode=="integer":
		settings_file.scale=floor(settings_file.scale)
	ProjectSettings.set_setting("display/window/stretch/scale",settings_file.scale)

func save_data()->void:
	ResourceSaver.save(settings_file,SETTINGS_PATH)
