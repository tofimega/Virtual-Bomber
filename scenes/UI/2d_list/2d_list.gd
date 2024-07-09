@tool
class_name List2D
extends Container

@export var offset_per_index: Vector2=Vector2(10,10):
	set(v):
		offset_per_index=v
		queue_sort()
		
func _ready():
	queue_sort()
	
func _notification(what):
	match what:
		NOTIFICATION_SORT_CHILDREN:
			var i: int=0
			for c in get_children():
				c.position=offset_per_index*i
				
				i+=1
		NOTIFICATION_CHILD_ORDER_CHANGED:
			queue_sort()
