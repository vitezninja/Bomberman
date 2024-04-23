extends Control
class_name MapSelectorMenu

@onready var offline_menu: PackedScene = load("res://Scenes/Menus/OfflineMenu.tscn")
@onready var rounds_input = %RoundsInput
@onready var map_1_checkbox = %Map1Checkbox
@onready var map_2_checkbox = %Map2Checkbox
@onready var map_3_checkbox = %Map3Checkbox

func _on_back_button_pressed() -> void:
	var offline: Control = offline_menu.instantiate()
	get_tree().get_first_node_in_group("Menu").add_child(offline)
	queue_free()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
	

func _on_start_button_pressed():
	var world_selector: WorldSelector = get_tree().get_first_node_in_group("WorldSelector")
	
	if world_selector == null:
		return
	
	if map_1_checkbox.button_pressed:
		world_selector.currentMap = world_selector.mapIdEnum.One
	elif map_2_checkbox.button_pressed:
		world_selector.currentMap = world_selector.mapIdEnum.Two
	elif map_3_checkbox.button_pressed:
		world_selector.currentMap = world_selector.mapIdEnum.Three
	else:
		return
	
	match rounds_input.text:
		"1":
			world_selector.gameCount = 1
		"2":
			world_selector.gameCount = 2
		"3":
			world_selector.gameCount = 3
		"4":
			world_selector.gameCount = 4
		"5":
			world_selector.gameCount = 5
		"6":
			world_selector.gameCount = 6
		"7":
			world_selector.gameCount = 7
		"8":
			world_selector.gameCount = 8
		"9":
			world_selector.gameCount = 9
		_:
			rounds_input.text = "1"
			return
	
	world_selector.startGame()
	GameStats.newSet()
	queue_free()
