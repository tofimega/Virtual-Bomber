class_name PlayerData
extends RefCounted





var player_id_set=false:
	set(d):
		player_id_set=true
var id: GlobalAccess.PlayerID: 
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
		n=n.dedent()
		n=n.strip_edges()
		n=n.strip_escapes()
		n=n.substr(0,6)
		name=n
		SignalBus.player_data_changed.emit(id)
	get:
		if name=="":
			return "Player "+str(id+1)
		return name

var points: int:
	set(p):
		points=clamp(p,1,99)
		SignalBus.player_data_changed.emit(id)

var explosion_range: int=1:
	set(r):
		var tmp=explosion_range
		explosion_range=clamp(r,1,99)
		if r>tmp:
			SignalBus.player_range_up.emit(id)
		SignalBus.player_data_changed.emit(id)
var capacity: int=1:
	set(c):
		var tmp=capacity
		capacity=clamp(c,1,99)
		
		if c>tmp:
			SignalBus.player_capacity_up.emit(id)
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
	SignalBus.bomb_placed.connect(func(b:Bomb):
		if b.player.id==id:
			bomb_count+=1
		)
	SignalBus.bomb_exploded.connect(func(b:Bomb):
		if b.player.id==id and bomb_count>0:
			bomb_count-=1
		)
		
	SignalBus.new_round.connect(reset_round_data)

func _inc_player_kill_count(killer_id: GlobalAccess.PlayerID,victim_id: GlobalAccess.PlayerID)->void:
	if killer_id == self.id and victim_id!=self.id:
		players_killed+=1


func _inc_enemy_kill_count(killer_id: GlobalAccess.PlayerID)->void:
	if killer_id == self.id:
		enemies_killed+=1


func reset_round_data()->void:
	explosion_range=1
	capacity=1
	bomb_count=0
