class_name GameModeSelect
extends Panel


@onready var spin_box: SpinBox = $MarginContainer/VBoxContainer/SpinBox

var wins: int=3


func _ready()->void:
	spin_box.value_changed.connect(func(new_value: float): wins=int(new_value))
