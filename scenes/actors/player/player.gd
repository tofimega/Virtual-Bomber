class_name Player
extends CharacterBody2D

@onready var player_sprite: Sprite2D = $PlayerSprite
@onready var hurt_box: Area2D = $HurtBox


var bombs:Array=[]
var movement_speed: int=200

var bomb_capacity: int=1
var bombs_on_field: int=0
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

func inc_boms(b)->void:
	bombs_on_field+=1
	bombs.append(b)

func dec_bombs(b)->void:
	bombs_on_field-=1
	bombs.erase(b)
#endregion

func _ready():
	hurt_box.body_entered.connect(kill)
	GlobalAccess.get_game_manager().add_player(self)


func _process(delta):
	move()
	place_bomb()
	

func place_bomb()->void:
	if Input.is_action_just_pressed(input_map.place_bomb):
		print(id)

func move()->void:
	velocity.x=Input.get_axis(input_map.left,input_map.right)*movement_speed
	velocity.y=Input.get_axis(input_map.up,input_map.down)*movement_speed
	
	move_and_slide()


func kill()->void:
	print("ow")
	#SignalBus.player_dead.emit(self)
	#queue_free()
	

	
	



