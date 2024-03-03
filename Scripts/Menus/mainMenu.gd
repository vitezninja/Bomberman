extends Node2D

@onready var infoMenu = preload("res://Scenes/Menus/InfoMenu.tscn")
@onready var creditsMenu = preload("res://Scenes/Menus/CreditsMenu.tscn")
@onready var keyBindsMenu = preload("res://Scenes/Menus/ChangeKeyBindsMenu.tscn")
@onready var MvsSMenu = preload("res://Scenes/Menus/MultiplayerVsSingleplayerMenu.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_play_pressed():
	get_tree().get_first_node_in_group("Menu").add_child(MvsSMenu.instantiate())
	queue_free()

func _on_info_pressed():
	get_tree().get_first_node_in_group("Menu").add_child(infoMenu.instantiate())
	queue_free()

func _on_credits_pressed():
	get_tree().get_first_node_in_group("Menu").add_child(creditsMenu.instantiate())
	queue_free()

func _on_key_binds_pressed():
	get_tree().get_first_node_in_group("Menu").add_child(keyBindsMenu.instantiate())
	queue_free()
