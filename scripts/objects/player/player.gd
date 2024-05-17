class_name Player
extends CharacterBody2D

@onready var player_sprite: Sprite2D = $PlayerSprite
@onready var hurt_box: Area2D = $HurtBox


var bombs:Array=[]
var movement_speed: int=2

var bomb_capacity: int=1
var bombs_on_field: int=0
var power: int=1

var input_map: PlayerInputMap

var id: GlobalAccess.PLAYER_ID:
	set (p):
		input_map=PlayerInputMap.get_input_map(p-1)
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


func _process(delta):
	move()
	place_bomb()

func place_bomb()->void:
	if Input.is_action_just_pressed(input_map.place_bomb):
		print(id)

func move()->void:
	if Input.is_action_pressed(input_map.left):
		position.x-=movement_speed
	if Input.is_action_pressed(input_map.right):
		position.x+=movement_speed
	if Input.is_action_pressed(input_map.up):
		position.y-=movement_speed
	if Input.is_action_pressed(input_map.down):
		position.y+=movement_speed


func kill()->void:
	SignalBus.player_dead.emit(self)
	queue_free()
	

	
	



