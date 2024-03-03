extends Node2D

@onready var mainMenu = preload("res://Scenes/Menus/MainMenu.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_back_pressed():
	get_tree().get_first_node_in_group("Menu").add_child(mainMenu.instantiate())
	queue_free()
