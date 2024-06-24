class_name SmartEnemy
extends BaseEnemy

var wandering: int=0

func pyth(a: Vector2)->float: 
	return sqrt((a.x**2)+(a.y**2))


func choose_direction()->void:
	
	var players:Array[Player]=GlobalAccess.get_game_manager().active_players
	if players==null || players.is_empty():
		super()
		return
	var nearest_player: Player=players[0]
	var delta_pos: Vector2=position-nearest_player.position
	
	for p in players:
		var tmp: Vector2=position-p.position
		if pyth(tmp)<pyth(delta_pos):
			nearest_player=p
			delta_pos=tmp
	
	
	var possible_horizontal: Vector2=Vector2.ZERO
	var possible_vertical: Vector2=Vector2.ZERO
	
	if delta_pos.x>0:
		possible_horizontal=Vector2.LEFT
	else: 
		possible_horizontal=Vector2.RIGHT
	if delta_pos.y>0:
		possible_vertical=Vector2.UP
	else:
		possible_vertical=Vector2.DOWN
		
		
	var first_candidate: Vector2=Vector2.ZERO
	var second_candidate: Vector2=Vector2.ZERO
	
	if abs(delta_pos.x)>abs(delta_pos.y):
		first_candidate=possible_horizontal
		second_candidate=possible_vertical
	else:
		first_candidate=possible_vertical
		second_candidate=possible_horizontal
		
		
	var remaining_directions: Array[Vector2]=[Vector2.UP,Vector2.DOWN,Vector2.RIGHT,Vector2.LEFT]
	remaining_directions.erase(first_candidate)
	remaining_directions.erase(second_candidate)
	
	if check(first_candidate):
		current_dir=first_candidate
	elif check(second_candidate):
		current_dir=second_candidate
	else:
		current_dir=remaining_directions[randi()%remaining_directions.size()]
		wandering=200
	
	
func check(dir: Vector2)->bool:
	var space: PhysicsDirectSpaceState2D=get_node("/root/GameScene").get_world_2d().get_direct_space_state()
	var params: PhysicsRayQueryParameters2D=PhysicsRayQueryParameters2D.new()
	params.collision_mask=collision_mask
	params.from=position
	params.to=position+(dir*speed*5)
	params.exclude=[self]
	
	var raw_data: Dictionary=space.intersect_ray(params)
	
	return raw_data["collider"]==null #BUG: always returns false



func _ready()->void:
	speed=150
	super.choose_direction()
	
func turn()->void:
	if turning: return
	turning=true
	velocity.x=-velocity.x
	velocity.y=-velocity.y
	move_and_slide()
	velocity.x=-velocity.x
	velocity.y=-velocity.y
	choose_direction()
	turning=false

func _physics_process(delta)->void:
	
	velocity.x=current_dir.x*speed
	velocity.y=current_dir.y*speed
	
	var b: bool=move_and_slide()
	
	if wandering<=0:
		if b:
			turn()
	elif !b:
		wandering-=1
	else:
		wandering=0
		turn()
