class_name GameModeSelect
extends Panel

var game_modes: Array[GameMode]=[
	SurvivalGameMode.new()
]

@onready var spin_box: SpinBox = $MarginContainer/VBoxContainer/SpinBox
@onready var option_button: OptionButton = $MarginContainer/VBoxContainer/OptionButton

var wins: int=3
var game_mode: GameMode= SurvivalGameMode.new()

func _ready()->void:
	spin_box.value_changed.connect(func(new_value: float): 
		wins=int(new_value)
		SignalBus.request_validate_gamemode.emit(game_mode)
	)
	option_button.item_selected.connect(func (index: int): 
		game_mode=game_modes[clamp(index,0,game_modes.size())]
		SignalBus.request_validate_gamemode.emit(game_mode)
		)
	SignalBus.request_validate_gamemode.emit.call_deferred(game_mode)
