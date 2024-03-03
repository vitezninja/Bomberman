extends Node2D

@onready var mainMenu = preload("res://Scenes/Menus/MainMenu.tscn")
@onready var onlineMenu = preload("res://Scenes/Menus/OnlineMenu.tscn")
@onready var offlineMenu = preload("res://Scenes/Menus/OfflineMenu.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_back_pressed():
	get_tree().get_first_node_in_group("Menu").add_child(mainMenu.instantiate())
	queue_free()

func _on_online_pressed():
	get_tree().get_first_node_in_group("Menu").add_child(onlineMenu.instantiate())
	queue_free()

func _on_offline_pressed():
	get_tree().get_first_node_in_group("Menu").add_child(offlineMenu.instantiate())
	queue_free()
