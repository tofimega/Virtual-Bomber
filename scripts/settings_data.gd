class_name SettingsData
extends Resource


@export_enum("fractional", "integer") var scale_mode: int=1:
	set(s):
		scale_mode=clamp(s,0,1)
		Settings.settings_changed.emit()
@export var filter:SubViewport.DefaultCanvasItemTextureFilter=SubViewport.DefaultCanvasItemTextureFilter.DEFAULT_CANVAS_ITEM_TEXTURE_FILTER_NEAREST:
	set(f):
		filter=f
		Settings.settings_changed.emit()
@export_range(1,10) var scale: float=2:
	set(s):
		if scale_mode==0:
			s=floor(s)
		clamp(s, 1, 10)
		scale=s
		Settings.settings_changed.emit()
