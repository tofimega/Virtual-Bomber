class_name BombIgnorer
extends Area2D


@export var target: PhysicsBody2D







func _on_body_entered(body):
	target.add_collision_exception_with(body)


func _on_body_exited(body):
	target.remove_collision_exception_with(body)
