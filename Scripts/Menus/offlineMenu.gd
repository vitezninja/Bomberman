extends Node2D

@onready var mainMenu = preload("res://Scenes/Menus/MainMenu.tscn")
@onready var mapSelectorMenu = preload("res://Scenes/Menus/MapSelectorMenu.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_back_pressed():
	get_tree().get_first_node_in_group("Menu").add_child(mainMenu.instantiate())
	queue_free()

#TODO
func _on_two_player_pressed():
	get_tree().get_first_node_in_group("Menu").add_child(mapSelectorMenu.instantiate())
	queue_free()

#TODO
func _on_three_player_pressed():
	get_tree().get_first_node_in_group("Menu").add_child(mapSelectorMenu.instantiate())
	queue_free()
