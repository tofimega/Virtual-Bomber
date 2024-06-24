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
var movement_speed: int=200

var bomb_capacity: int=1
var bomb_count: int:
	set(b):
		pass
	get:
		return len(bombs)
var power: int=1

var input_map: PlayerInputMap

var id: GlobalAccess.PLAYER_ID:
	set (p):
		input_map=PlayerInputMap.get_input_map(p)
		id=p
		#TODO: set sprite

#region incs, decs
func inc_capacity()->void:
	bomb_capacity+=1

func inc_power()->void:
	power+=1

func inc_bombs(b:Bomb)->void:
	if b.player==self:
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
		var tile_size=GlobalAccess.get_level_grid().get_tileset().tile_size
		bomb.position.x=position.x-(int(position.x)% tile_size.x)
		bomb.position.y=position.y-(int(position.y)% tile_size.y)
		bomb.player=self
		GlobalAccess.get_actor_container().add_child.call_deferred(bomb)
		


func move()->void:
	velocity.x=Input.get_axis(input_map.left,input_map.right)*movement_speed
	velocity.y=Input.get_axis(input_map.up,input_map.down)*movement_speed
	
	move_and_slide()


func kill(arae)->void:
	print("ow")
	SignalBus.player_dead.emit(self)
	queue_free()
	


	
	



