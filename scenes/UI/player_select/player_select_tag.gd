class_name PlayerSelectTag
extends Control

@onready var texture_rect: TextureRect = $TextureRect
@onready var remove_player_button: Button = $RemovePlayer
@onready var control_style: Button  = $ControlStyle
@onready var player_name: LineEdit = $PlayerName


var id: GlobalAccess.PLAYER_ID

func _ready()->void:
	remove_player_button.pressed.connect(remove_player)
	player_name.text_changed.connect(func(new_name: String): SignalBus.player_name_changed.emit(id,new_name))



func remove_player()->void:
	SignalBus.request_remove_player.emit(id)
