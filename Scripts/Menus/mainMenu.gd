class_name MainMenu
extends Control

@onready var keybinds_menu: PackedScene = load("res://Scenes/Menus/KeybindsMenu.tscn")
@onready var test_world: PackedScene = load("res://Scenes/Maps/TestWorld.tscn")  
@onready var credits_menu: PackedScene = load("res://Scenes/Menus/CreditsMenu.tscn")
@onready var info_menu: PackedScene = load("res://Scenes/Menus/InfoMenu.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_play_button_pressed() -> void:
	var world = test_world.instantiate()
	get_tree().get_first_node_in_group("WorldSelector").add_child(world)
	queue_free()

func _on_info_button_pressed() -> void:
	var info = info_menu.instantiate()
	get_tree().get_first_node_in_group("Menu").add_child(info)
	queue_free()


func _on_credits_button_pressed():
	var credits = credits_menu.instantiate()
	get_tree().get_first_node_in_group("Menu").add_child(credits)
	queue_free()


func _on_keybinds_button_pressed():
	var keybinds = keybinds_menu.instantiate()
	get_tree().get_first_node_in_group("Menu").add_child(keybinds)
	queue_free()
