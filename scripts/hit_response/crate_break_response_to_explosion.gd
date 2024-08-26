class_name BreakCrate
extends HitResponse


func respond_area(target: Node, collider: Area2D)->void:
	if collider is Explosion and target is Crate:
		target.crack()
