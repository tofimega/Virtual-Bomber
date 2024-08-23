class_name Spreader
extends Node2D

@export var explosion: Explosion

@onready var top: Area2D = $Top
@onready var right: Area2D = $Right
@onready var bottom: Area2D = $Bottom
@onready var left: Area2D = $Left


signal spread_complete




func _ready():
	top.body_entered.connect(test)
	set_direction()

func set_direction()->void:
	match explosion.direction:
		Explosion.SpreadDirection.SOURCE:
			top.monitoring=true
			bottom.monitoring=true
			left.monitoring=true
			right.monitoring=true
		Explosion.SpreadDirection.UP:
			top.monitoring=true
			bottom.monitoring=false
			left.monitoring=false
			right.monitoring=false
		Explosion.SpreadDirection.DOWN:
			top.monitoring=false
			bottom.monitoring=true
			left.monitoring=false
			right.monitoring=false
		Explosion.SpreadDirection.LEFT:
			top.monitoring=false
			bottom.monitoring=false
			left.monitoring=true
			right.monitoring=false
		Explosion.SpreadDirection.RIGHT:
			top.monitoring=false
			bottom.monitoring=false
			left.monitoring=false
			right.monitoring=true

func spread()->void:
	if explosion.raw_power<=0:
		pass
	match explosion.direction:
		Explosion.SpreadDirection.SOURCE:
			spread_to.call_deferred(Explosion.SpreadDirection.UP)
			spread_to.call_deferred(Explosion.SpreadDirection.RIGHT)
			spread_to.call_deferred(Explosion.SpreadDirection.DOWN)
			spread_to.call_deferred(Explosion.SpreadDirection.LEFT)
			
		_:  spread_to.call_deferred(explosion.direction)
	
	spread_complete.emit()

func test(b):
	print(b)

func spread_to(direction: Explosion.SpreadDirection)->void:
	if explosion.raw_power==0: return
	var level_grid: TileMapContainer=GlobalAccess.get_level_grid()
	
	var new_pos: Vector2=Vector2(explosion.position)

	
	explosion.true_power=explosion.raw_power
	
	match direction:
		Explosion.SpreadDirection.UP:
			set_power(top)
			new_pos.y-=level_grid.object.tile_set.tile_size.y
		Explosion.SpreadDirection.DOWN:
			set_power(bottom)
			new_pos.y+=level_grid.object.tile_set.tile_size.y
		Explosion.SpreadDirection.LEFT:
			set_power(left)
			new_pos.x-=level_grid.object.tile_set.tile_size.x
		Explosion.SpreadDirection.RIGHT:
			set_power(right)
			new_pos.x+=level_grid.object.tile_set.tile_size.x
	if explosion.true_power>0:
		
		
		var nextplosion: Explosion=preload("res://scenes/actors/bomb/explosion/explosion.tscn").instantiate()
		nextplosion.player=explosion.player
		nextplosion.position=new_pos
		nextplosion.true_power=explosion.true_power-1
		nextplosion.raw_power=explosion.true_power-1
		nextplosion.direction=direction
		GlobalAccess.get_actor_container().add_child.call_deferred(nextplosion)


func set_power(checker:Area2D)->void:
	if explosion.raw_power==0: return 
	
	var space: PhysicsDirectSpaceState2D=GlobalAccess.get_game_scene().get_world_2d().get_direct_space_state()
	var params: PhysicsShapeQueryParameters2D=PhysicsShapeQueryParameters2D.new()
	params.collision_mask=checker.collision_mask
	params.shape=checker.get_children()[0].shape
	params.transform=checker.get_children()[0].get_global_transform()
	
	var raw_data: Array[Dictionary]=space.intersect_shape(params)
	
	
	for body_info in raw_data:
		
		var body: CollisionObject2D=body_info["collider"]
		
		
		
		if body is Crate or body is Bomb:
			explosion.true_power=1
			return
		else:
			explosion.true_power=0
			return
