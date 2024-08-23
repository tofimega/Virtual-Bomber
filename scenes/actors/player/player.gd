class_name Player
extends CharacterBody2D

@onready var player_sprite: Sprite2D = $PlayerSprite as Sprite2D
@onready var hurt_box: Area2D = $HurtBox as Area2D
@onready var bomb_ignorer = $BombIgnorer as BombIgnorer


var can_place: bool:
	set(p):
		pass
	get:
		return bomb_count<bomb_capacity && !bomb_ignorer.colliding

var bombs:Array=[]
const movement_speed: int=200


var bomb_count: int:
	set(b):
		pass
	get:
		return len(bombs)
var power: int:
	set(s):
		pass
	get:
		return GlobalAccess.game_settings.get_player_data(id).range

var bomb_capacity: int:
	set(s):
		pass
	get:
		return GlobalAccess.game_settings.get_player_data(id).capacity


var input_map: PlayerInputMap

var id: GlobalAccess.PLAYER_ID:
	set (p):
		#TODO: set player data in GlobalAccess
		input_map=PlayerInputMap.get_input_map(p)
		id=p
		#TODO: set sprite

#region incs, decs
func inc_capacity()->void:
	SignalBus.player_capacity_up.emit(id)

func inc_power()->void:
	SignalBus.player_range_up.emit(id)

func inc_bombs(b:Bomb)->void:
	if b.player.id==id:
		bombs.append(b)

func dec_bombs(b: Bomb)->void:
	remove_collision_exception_with(b)
	bombs.erase(b)
#endregion

func _ready():
	SignalBus.bomb_exploded.connect(dec_bombs)
	SignalBus.bomb_placed.connect(inc_bombs)
	hurt_box.area_entered.connect(kill)
	hurt_box.body_entered.connect(kill)
	SignalBus.player_ready.emit(self)
	

func _physics_process(delta):
	move()
	place_bomb()
	

func place_bomb()->void:
	if Input.is_action_just_pressed(input_map.place_bomb) && can_place:
		var bomb:Bomb=preload("res://scenes/actors/bomb/bomb.tscn").instantiate()
		var tile_size=GlobalAccess.get_level_grid().object.tile_set.tile_size
		bomb.position.x=position.x-(int(position.x)% tile_size.x)
		bomb.position.y=position.y-(int(position.y)% tile_size.y)
		bomb.player=GlobalAccess.game_settings.get_player_data(id)
		GlobalAccess.get_actor_container().add_child.call_deferred(bomb)
		


func move()->void:
	velocity.x=Input.get_axis(input_map.left,input_map.right)*movement_speed
	velocity.y=Input.get_axis(input_map.up,input_map.down)*movement_speed
	
	move_and_slide()


func kill(area)->void:
	if area is Explosion:
		SignalBus.player_killed_player.emit(area.player_id,self.id)
	
	GlobalAccess.game_settings.player_data[id].deaths+=1
	print("ow")
	SignalBus.player_dead.emit(self.id)
	queue_free()
	


	
	
