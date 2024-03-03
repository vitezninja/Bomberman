extends Node2D

@onready var mainMenu = preload("res://Scenes/Menus/MainMenu.tscn")
@onready var hostMenu = preload("res://Scenes/Menus/HostMenu.tscn")
@onready var joinMenu = preload("res://Scenes/Menus/JoinMenu.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_back_pressed():
	get_tree().get_first_node_in_group("Menu").add_child(mainMenu.instantiate())
	queue_free()

func _on_host_pressed():
	get_tree().get_first_node_in_group("Menu").add_child(hostMenu.instantiate())
	queue_free()

func _on_join_pressed():
	get_tree().get_first_node_in_group("Menu").add_child(joinMenu.instantiate())
	queue_free()
