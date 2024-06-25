class_name BombIgnorer
extends Area2D


@export var target: PhysicsBody2D
@export var shape: CollisionShape2D

var colliding:bool=false

var colliders: Array[CollisionObject2D]=[]

func _ready():
	SignalBus.bomb_exploded.connect(remove_extra)
	SignalBus.player_placing_bomb.connect(early_overlap_ignore)


func remove_extra(bomb:Bomb)->void:
	if target.get_collision_exceptions().has(bomb):
		_on_body_exited(bomb)


func early_overlap_ignore(bomb:Bomb)->void:
	if target.get_collision_exceptions().has(bomb): return
	if shape.shape.collide(shape.get_global_transform(),bomb.collision_shape.shape,bomb.collision_shape.get_global_transform()):
		_on_body_entered(bomb)


func _on_body_entered(body):
	if target.get_collision_exceptions().has(body): return
	colliding=true
	target.add_collision_exception_with(body)


func _on_body_exited(body):
	colliding=false
	target.remove_collision_exception_with(body)
