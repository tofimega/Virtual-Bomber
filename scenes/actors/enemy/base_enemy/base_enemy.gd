class_name BaseEnemy
extends CharacterBody2D

@onready var collision_shape_2d = $CollisionShape2D
@onready var hurt_box = $HurtBox

@onready var timer = $Timer
@export var speed: int=150

var current_dir: Vector2

func _ready():
	hurt_box.area_entered.connect(kill)
	hurt_box.body_entered.connect(kill)
	timer.timeout.connect(turn)
	timer.start(randf_range(1,5))
	choose_direction()

func choose_direction()->void:
		match randi()%4:
			0: current_dir=Vector2.RIGHT
			1: current_dir=Vector2.DOWN
			2: current_dir=Vector2.LEFT
			_: current_dir=Vector2.UP


func _physics_process(delta):
	
	velocity.x=current_dir.x*speed
	velocity.y=current_dir.y*speed
	
	var b: bool=move_and_slide()
	
	if b:
		turn()

var turning: bool=false
func turn()->void:
	if turning: return
	turning=true
	velocity.x=-velocity.x
	velocity.y=-velocity.y
	move_and_slide()
	velocity.x=-velocity.x
	velocity.y=-velocity.y
	choose_direction()
	timer.start(randf_range(1,5)) 
	turning=false
	


	
func kill(a)->void:
	queue_free()


