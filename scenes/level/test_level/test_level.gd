extends Node2D

@onready var tile_map: TileMapContainer = $TileMap


func _ready():
	var level_data: String =FileAccess.get_file_as_string(GlobalAccess.level_to_load)
	
	var lines: PackedStringArray=level_data.split('\n')
	
	var row:int=0
	var col:int=0
	
	
	
	
	for line in lines:
		col=0
		if row<16:
		
			for char in line:
				spawn_tile(char,row,col)
				col+=1
			row+=1
		else:
			var o: PackedStringArray=line.split(" ")
			if len(o)==3:
				spawn_object(o[0],int(o[2]),int(o[1]))
	
	
	SignalBus.level_loaded.emit.call_deferred()

func spawn_object(o: String,row:int,col:int)->void:
	var pos:Vector2i=Vector2i(col,row)
	
	match o:
		'p': tile_map.object.set_cell(pos,3,Vector2i.ZERO,0)
		_: place_enemy(pos,o)

func place_enemy(tile_pos: Vector2i, enemy_type: String):
	var enm: PackedScene
	
	match enemy_type:
		'be':enm=ResourceLoader.load("res://scenes/actors/enemy/base_enemy/base_enemy.tscn")
		'ge':enm=ResourceLoader.load("res://scenes/actors/enemy/ghost_enemy/ghost_enemy.tscn")
		'se':enm=ResourceLoader.load("res://scenes/actors/enemy/smart_enemy/smart_enemy.tscn")
		'ce':enm=ResourceLoader.load("res://scenes/actors/enemy/chaser_enemy/chaser_enemy.tscn")
		_: return
	var true_pos: Vector2=Vector2(tile_pos)
	true_pos*=Vector2(tile_map.object.tile_set.tile_size)
	true_pos+=Vector2(tile_map.object.tile_set.tile_size)/2
	var spawner: EnemySpawn=EnemySpawn.new(enm)
	spawner.global_position=true_pos
	tile_map.object.add_child.call_deferred(spawner)
	

func spawn_tile(o: String, row: int, col: int)->void:
	var pos: Vector2i=Vector2i(col,row)
	match o:
		'x': return
		'e': return
		'w': tile_map.edge_top.set_cell(pos,2,Vector2i.ZERO,2)
		'c': tile_map.edge_top.set_cell(pos,2,Vector2i.ZERO,1)
		
		
