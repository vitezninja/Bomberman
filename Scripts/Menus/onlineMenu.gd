extends Control
class_name OnlineMenu

@onready var game_mode_menu: PackedScene = load("res://Scenes/Menus/GameModeMenu.tscn")


func _on_back_button_pressed() -> void:
	var gamemode: Control = game_mode_menu.instantiate()
	get_tree().get_first_node_in_group("Menu").add_child(gamemode)
	get_tree().get_first_node_in_group("Client").queue_free()
	queue_free()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
