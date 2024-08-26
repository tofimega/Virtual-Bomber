class_name HitResponder
extends Area2D


@export var target: Node

@export var response: HitResponse= HitResponse.new()

func _ready()->void:
	body_entered.connect(func(body: Node2D): response.respond_body(target, body))
	area_entered.connect(func(area: Area2D): response.respond_area(target, area))
