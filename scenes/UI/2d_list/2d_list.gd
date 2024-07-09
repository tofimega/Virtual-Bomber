@tool
class_name List2D
extends Container

@export var offset_x: float=100:
	set(x):
		offset_x=x
		queue_sort()
@export var offset_y: float=100:
	set(y):
		offset_y=y
		queue_sort()

func _ready():
	queue_sort()
	
func _notification(what):
	match what:
		NOTIFICATION_SORT_CHILDREN:
			var i: int=0
			for c in get_children():
				c.position.x=(offset_x*i)
				c.position.y=(offset_y*i)
				
				i+=1
		NOTIFICATION_CHILD_ORDER_CHANGED:
			queue_sort()
