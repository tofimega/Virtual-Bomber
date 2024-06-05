class_name BombIgnorer
extends Area2D


@export var target: PhysicsBody2D


var colliding:bool=false




func _on_body_entered(body):
	colliding=true
	target.add_collision_exception_with(body)


func _on_body_exited(body):
	colliding=false
	target.remove_collision_exception_with(body)
