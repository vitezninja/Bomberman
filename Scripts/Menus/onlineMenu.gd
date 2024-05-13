extends Control
class_name OnlineMenu

const MAIN_MENU: PackedScene = preload("res://Scenes/Menus/MainMenu.tscn")
@onready var ready_button: Button = %ReadyButton


func _ready():
	var world_selector: WorldSelector = get_tree().get_first_node_in_group("WorldSelector")
	if world_selector == null:
		return

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_back_to_menu_button_pressed():
	var main: Control = MAIN_MENU.instantiate()
	get_tree().get_first_node_in_group("Menu").add_child(main)
	queue_free()


func _on_ready_button_pressed():
	var world_selector: WorldSelector = get_tree().get_first_node_in_group("WorldSelector")
	if world_selector == null:
		return
		
	world_selector.startGame()
	queue_free()
