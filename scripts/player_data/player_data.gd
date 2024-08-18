class_name PlayerData
extends RefCounted





var player_id_set=false:
	set(d):
		player_id_set=true
var id: GlobalAccess.PLAYER_ID: 
	set(i):
		if !player_id_set:
			id=i
			player_id_set=true
		

var icon: Texture2D=ResourceLoader.load("res://icon.svg"):
	set(i):
		icon=i
		SignalBus.player_data_changed.emit(id)

var name: String="":
	set(n):
		name=n
		SignalBus.player_data_changed.emit(id)
	get:
		if name=="":
			return "Player "+str(id+1)
		return name

var points: int:
	set(p):
		points=p
		SignalBus.player_data_changed.emit(id)

var range: int=1:
	set(r):
		range=r
		SignalBus.player_data_changed.emit(id)
var capacity: int=1:
	set(c):
		capacity=c
		SignalBus.player_data_changed.emit(id)

var deaths: int=0:
	set(d):
		deaths=d
		SignalBus.player_data_changed.emit(id)

var bomb_count: int=0:
	set(b):
		bomb_count=b
		SignalBus.player_data_changed.emit(id)
var players_killed: int=0:
	set(p): 
		players_killed=p
		SignalBus.player_data_changed.emit(id)
var enemies_killed: int=0:
	set(e):
		enemies_killed=e
		SignalBus.player_data_changed.emit(id)

func _init()->void:
	SignalBus.player_killed_player.connect(_inc_player_kill_count)
	SignalBus.player_killed_enemy.connect(_inc_enemy_kill_count)
	SignalBus.player_capacity_up.connect(func(id: GlobalAccess.PLAYER_ID):
		if id==self.id:	capacity+=1
		)
	SignalBus.player_range_up.connect(func(id:GlobalAccess.PLAYER_ID):
		if id==self.id:
			range+=1
		)
		
	SignalBus.bomb_placed.connect(func(b:Bomb):
		if b.id==id:
			bomb_count+=1
		)
	SignalBus.bomb_exploded.connect(func(b:Bomb):
		if b.id==id:
			bomb_count-=1
		)
		
	SignalBus.new_round.connect(reset_round_data)

func _inc_player_kill_count(id: GlobalAccess.PLAYER_ID,victim_id: GlobalAccess.PLAYER_ID)->void:
	if id == self.id and victim_id!=self.id:
		players_killed+=1


func _inc_enemy_kill_count(id: GlobalAccess.PLAYER_ID)->void:
	if id == self.id:
		enemies_killed+=1


func reset_round_data()->void:
	range=1
	capacity=1
	bomb_count==0
