extends Control
class_name OfflineMenu

@onready var game_mode_menu: PackedScene = load("res://Scenes/Menus/GameModeMenu.tscn")
@onready var map_selector: PackedScene = load("res://Scenes/Menus/MapSelectorMenu.tscn")


func _on_back_button_pressed() -> void:
	var gamemode: Control = game_mode_menu.instantiate()
	get_tree().get_first_node_in_group("Menu").add_child(gamemode)
	queue_free()


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_two_players_pressed():
	var selector: Control = map_selector.instantiate()
	get_tree().get_first_node_in_group("Menu").add_child(selector)
	queue_free()


func _on_three_players_pressed():
	var selector: Control = map_selector.instantiate()
	get_tree().get_first_node_in_group("Menu").add_child(selector)
	queue_free()
