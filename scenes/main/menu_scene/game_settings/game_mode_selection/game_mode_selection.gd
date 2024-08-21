class_name GameModeSelect
extends Panel


@onready var spin_box: SpinBox = $MarginContainer/VBoxContainer/SpinBox
@onready var option_button: OptionButton = $MarginContainer/VBoxContainer/OptionButton

var wins: int=3
var game_mode: GameMode

func _ready()->void:
	spin_box.value_changed.connect(func(new_value: float): wins=int(new_value))
