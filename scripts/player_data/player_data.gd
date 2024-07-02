class_name PlayerData
extends Object


var id: GlobalAccess.PLAYER_ID: 
	set(i):
		id=i
		name="Player "+str(i+1)

var icon: Texture2D=ResourceLoader.load("res://icon.svg"):
	set(i):
		icon=i
		SignalBus.player_data_changed.emit(id)

var name: String="Player"+ " "+ str(id+1):
	set(n):
		name=n
		SignalBus.player_data_changed.emit(id)

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


func _inc_player_kill_count(id: GlobalAccess.PLAYER_ID)->void:
	if id == self.id:
		players_killed+=1


func _inc_enemy_kill_count(id: GlobalAccess.PLAYER_ID)->void:
	if id == self.id:
		enemies_killed+=1
