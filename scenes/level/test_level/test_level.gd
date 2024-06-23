extends Node2D

@onready var tile_map = $TileMap


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
	
	
	SignalBus.call_deferred("emit_level_loaded")

func spawn_object(o: String,row:int,col:int)->void:
	var pos:Vector2i=Vector2i(col,row)
	
	match o:
		'p': tile_map.set_cell(2,pos,3,Vector2i.ZERO,0)
		'be':tile_map.set_cell(2,pos,3,Vector2i.ZERO,1)
		'ge':return
		'se':return
		'ce':return



func spawn_tile(o: String, row: int, col: int)->void:
	var pos: Vector2i=Vector2i(col,row)
	match o:
		'x': return
		'e': return
		'w': tile_map.set_cell(1,pos,2,Vector2i.ZERO,2)
		'c': tile_map.set_cell(1,pos,2,Vector2i.ZERO,1)
		
		
