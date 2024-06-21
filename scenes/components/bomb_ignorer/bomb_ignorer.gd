class_name BombIgnorer
extends Area2D


@export var target: PhysicsBody2D
@export var shape: CollisionShape2D

var colliding:bool=false

func _ready():
	SignalBus.player_placing_bomb.connect(early_overlap_ignore)


func early_overlap_ignore(bomb:Bomb)->void:
	if shape.shape.collide(shape.get_transform(),bomb.collision_shape.shape,bomb.collision_shape.get_transform()):
		_on_body_entered(bomb)


func _on_body_entered(body):
	colliding=true
	target.add_collision_exception_with(body)


func _on_body_exited(body):
	colliding=false
	target.remove_collision_exception_with(body)
