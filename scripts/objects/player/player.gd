class_name Player
extends CharacterBody2D

@onready var player_sprite: Sprite2D = $PlayerSprite
@onready var hurt_box: Area2D = $HurtBox


var bombs:Array=[]
var movement_speed: int=2

var bomb_capacity: int=1
var bombs_on_field: int=0
var power: int=1

var input_map: Dictionary

var id: GlobalAccess.player_id:
	set (p):
		id=p
		input_map=GlobalAccess.controls[p]
		#TODO: set sprite & controller

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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func kill()->void:
	queue_free()
	




