class_name ExplodeBomb
extends HitResponse


func respond_area(target: Node, collider: Area2D)->void:
	if target is Bomb and collider is Explosion:
		target.explode()
