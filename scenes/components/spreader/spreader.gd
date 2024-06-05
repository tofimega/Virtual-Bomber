class_name Spreader
extends Node2D

@export var explosion: Explosion

@onready var top: Area2D = $Top
@onready var right: Area2D = $Right
@onready var bottom: Area2D = $Bottom
@onready var left: Area2D = $Left


signal spread_complete




func _ready():

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
			spread_to(Explosion.SpreadDirection.UP)
			spread_to(Explosion.SpreadDirection.RIGHT)
			spread_to(Explosion.SpreadDirection.DOWN)
			spread_to(Explosion.SpreadDirection.LEFT)
		_: spread_to(explosion.direction)
	
	spread_complete.emit()


func spread_to(direction: Explosion.SpreadDirection)->void:
	var level_grid: TileMap=GlobalAccess.get_level_grid()
	
	var new_pos: Vector2=Vector2(explosion.position)

	explosion.true_power=explosion.raw_power
	match direction:
		Explosion.SpreadDirection.UP:
			set_power(top)
			new_pos.y-=level_grid.get_tileset().tile_size.y
		Explosion.SpreadDirection.DOWN:
			set_power(bottom)
			new_pos.y+=level_grid.get_tileset().tile_size.y
		Explosion.SpreadDirection.LEFT:
			set_power(left)
			new_pos.x-=level_grid.get_tileset().tile_size.x
		Explosion.SpreadDirection.RIGHT:
			set_power(right)
			new_pos.x+=level_grid.get_tileset().tile_size.x
	if explosion.true_power>0:
		
		
		var nextplosion: Explosion=ResourceLoader.load("res://scenes/actors/bomb/explosion/explosion.tscn").instantiate()

		nextplosion.position=new_pos
		nextplosion.true_power=explosion.true_power-1
		nextplosion.raw_power=explosion.true_power-1
		nextplosion.direction=direction
		GlobalAccess.get_actor_container().add_child.call_deferred(nextplosion)


func set_power(checker:Area2D)->void:
	for body in checker.get_overlapping_bodies():
		
		if body is Crate:
			explosion.true_power=1
		else:
			explosion.true_power=0
			return
