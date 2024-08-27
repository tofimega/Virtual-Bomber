class_name SettingsData
extends Resource


@export var scale_mode: Window.ContentScaleStretch=Window.ContentScaleStretch.CONTENT_SCALE_STRETCH_INTEGER:
	set(s):
		scale_mode=clamp(s,0,1)
		Settings.settings_changed.emit()
@export var filter:SubViewport.DefaultCanvasItemTextureFilter=SubViewport.DefaultCanvasItemTextureFilter.DEFAULT_CANVAS_ITEM_TEXTURE_FILTER_NEAREST:
	set(f):
		filter=f
		Settings.settings_changed.emit()

@export var window_mode: DisplayServer.WindowMode=DisplayServer.WindowMode.WINDOW_MODE_EXCLUSIVE_FULLSCREEN: 
	set(m):
		window_mode=m
		Settings.settings_changed.emit()
