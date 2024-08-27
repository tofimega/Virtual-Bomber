class_name PlayerSelect
extends Panel

@onready var player_tags: HBoxContainer =  $MarginContainer/PlayerTags

var player_count: int=2

var player_tag_scene:PackedScene=preload("res://scenes/UI/player_select/player_select_tag.tscn")
var new_button_scene: PackedScene=preload("res://scenes/main/menu_scene/game_settings/player_tags_container/new_player_button/new_player.tscn")




func _ready()->void:
	SignalBus.request_add_player.connect(try_add_player)
	SignalBus.request_remove_player.connect(try_remove_player)
	
func try_add_player()->void:
	if player_count<4:
		var new_tag:PlayerSelectTag=player_tag_scene.instantiate()
		new_tag.id=player_count as GlobalAccess.PlayerID
		if player_tags.get_children()[-1] is Button:
			player_tags.add_child(new_tag)
			player_tags.move_child(new_tag,player_tags.get_children().size()-2)
		else:
			player_tags.add_child(new_tag)
		player_count+=1
		if player_count==4:
			player_tags.remove_child(player_tags.get_children()[-1])
		SignalBus.player_added.emit(player_count-1)
		
func try_remove_player(id: GlobalAccess.PlayerID)->void:
	if player_count>2:
		player_tags.remove_child(player_tags.get_child(id))
		var i: int=0
		for n: Node in player_tags.get_children():
			if n is PlayerSelectTag:
				n.id=i
				i+=1
		if not player_tags.get_children()[-1] is Button:
			player_tags.add_child(new_button_scene.instantiate())
		player_count-=1
		SignalBus.player_removed.emit(id)
		
