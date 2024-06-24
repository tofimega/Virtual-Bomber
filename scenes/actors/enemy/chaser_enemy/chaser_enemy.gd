class_name ChaserEnemy
extends SmartEnemy

func _ready()->void:
	speed=150


func choose_direction()->void:
	if randi()%4==0:
		match randi()%4:
			0: current_dir=Vector2.UP
			1: current_dir=Vector2.DOWN
			2: current_dir=Vector2.LEFT
			_: current_dir=Vector2.RIGHT
	else:
		super()
	
	var t: TileMap=GlobalAccess.get_level_grid()
	if t!=null:
		if current_dir==Vector2.UP||current_dir==Vector2.DOWN:
			wandering=t.tile_set.tile_size.y/2
		else:
			wandering=t.tile_set.tile_size.x/2
	else:
		wandering=0

func _physics_process(delta):
	velocity.x=current_dir.x*speed
	velocity.y=current_dir.y*speed
	
	var b: bool=move_and_slide()
	
	if wandering<=0:
		
		turn()
	elif !b:
		wandering-=1
	else:
		wandering=0
		turn()

