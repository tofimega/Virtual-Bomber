class_name MenuScene
extends Control

@onready var menu_state_machine: MenuStateMachine = $MenuStateMachine

@onready var main_menu: List2D = $Interface/MainMenu
@onready var edit_level: List2D = $Interface/EditLevel

func switch_list(to: List2D, forward: bool)->void:
	menu_state_machine.old_list=menu_state_machine.new_list
	menu_state_machine.new_list=to
	if forward:
		menu_state_machine.switch_state(menu_state_machine.states["MenuStillState"],menu_state_machine.states["MenuTransitionForwardState"])
	else:
		menu_state_machine.switch_state(menu_state_machine.states["MenuStillState"],menu_state_machine.states["MenuTransitionBackwardState"])
	


func _ready()->void:
	menu_state_machine.final_positions[main_menu]=Vector2(50,470)
	menu_state_machine.final_positions[edit_level]=Vector2(35,470)
	menu_state_machine.new_list=main_menu
	menu_state_machine.start()


func _on_exit_pressed():
	get_tree().quit(0)


func _on_settings_pressed():
	SceneControl.replace_game_scene(ResourceLoader.load("res://scenes/main/menu_scene/settings_menu/settings_menu.tscn"))


func _on_edit_level_pressed():
	switch_list(edit_level,true)


func _on_start_game_pressed():
	SceneControl.replace_game_scene(ResourceLoader.load("res://scenes/main/menu_scene/game_settings/game_settings_scene.tscn"))


func _on_back_pressed():
	switch_list(main_menu,false)


func _on_load_level_pressed():
	print("editor not a thing yet")


func _on_new_level_pressed():
	print("editor not a thing yet")
