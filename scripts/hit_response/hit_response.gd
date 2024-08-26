class_name HitResponse
extends Resource




func respond_body(target: Node, collider: Node2D)->void:
	print("body boop")

func respond_area(target: Node, collider: Area2D)->void:
	print("area boop")
