extends Control
class_name GameModeMenu

const MAIN_MENU: PackedScene = preload("res://Scenes/Menus/MainMenu.tscn")
@onready var offline_menu: PackedScene = load("res://Scenes/Menus/OfflineMenu.tscn")
@onready var online_menu: PackedScene = load("res://Scenes/Menus/OnlineMenu.tscn")


func _on_back_button_pressed() -> void:
	var main: Control = MAIN_MENU.instantiate()
	get_tree().get_first_node_in_group("Menu").add_child(main)
	queue_free()


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_offline_pressed() -> void:
	var world_selector: WorldSelector = get_tree().get_first_node_in_group("WorldSelector")
	
	if world_selector == null:
		return
		
	world_selector.gameType = world_selector.gameTypeEnum.Offline
	
	var offline: Control = offline_menu.instantiate()
	get_tree().get_first_node_in_group("Menu").add_child(offline)
	queue_free()
	



func _on_online_pressed() -> void:
	var world_selector: WorldSelector = get_tree().get_first_node_in_group("WorldSelector")
	
	if world_selector == null:
		return
		
	world_selector.gameType = world_selector.gameTypeEnum.Online
	
	var online: Control = online_menu.instantiate()
	get_tree().get_first_node_in_group("Menu").add_child(online)
	Network.addClient()
	queue_free()
