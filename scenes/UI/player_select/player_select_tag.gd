class_name PlayerSelectTag
extends Control

@onready var texture_rect: TextureRect = $TextureRect
@onready var remove_player_button: Button = $RemovePlayer
@onready var control_style: Button  = $ControlStyle
@onready var player_name: LineEdit = $PlayerName


var id: GlobalAccess.PlayerID: 
	set(i):
		id=i
		SignalBus.player_settings_changed.emit(i)

func _ready()->void:
	remove_player_button.pressed.connect(remove_player)
	player_name.text_changed.connect(func (_t: String): SignalBus.player_settings_changed.emit(id))
	SignalBus.player_settings_changed.emit.call_deferred(0)


func remove_player()->void:
	SignalBus.request_remove_player.emit(id)
