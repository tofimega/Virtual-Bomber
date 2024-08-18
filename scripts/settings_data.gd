class_name SettingsData
extends Resource

var scale_to_string: Array[String]=["fractional","integer"]

@export_enum("fractional", "integer") var scale_mode: int=1:
	set(s):
		scale_mode=clamp(s,0,1)
		Settings.settings_changed.emit()
@export var filter:SubViewport.DefaultCanvasItemTextureFilter=SubViewport.DefaultCanvasItemTextureFilter.DEFAULT_CANVAS_ITEM_TEXTURE_FILTER_NEAREST:
	set(f):
		filter=f
		Settings.settings_changed.emit()
