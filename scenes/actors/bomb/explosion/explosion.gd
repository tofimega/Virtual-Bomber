class_name Explosion
extends Area2D


var raw_power: int=0
var true_power: int=0
var player_id: GlobalAccess.PLAYER_ID
var direction: SpreadDirection

@onready var spreader: Spreader = $Spreader


@onready var spread_timer: Timer = $SpreadTimer
@onready var dissipate_timer: Timer = $DissipateTimer


func _ready()->void:
	spread_timer.timeout.connect(spreader.spread)
	spreader.spread_complete.connect(dissipate_timer.start)
	dissipate_timer.timeout.connect(dissipate)
	SignalBus.new_explosion_on_field.emit()
	spread_timer.start.call_deferred()


func dissipate()->void:
	SignalBus.explosion_dissipated.emit()
	queue_free()



enum SpreadDirection{
	SOURCE,
	UP,
	DOWN,
	LEFT,
	RIGHT,
}
