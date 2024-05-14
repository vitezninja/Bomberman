extends Control
class_name OnlineMenu

const MAIN_MENU: PackedScene = preload("res://Scenes/Menus/MainMenu.tscn")
@onready var ready_button: Button = %ReadyButton
@onready var ready_count: Label = %ReadyCount
@onready var map_pic: TextureRect = %MapPic
const MAP_1: Resource = preload("res://Assets/GUI/MapIcons/map1.png")
const MAP_2: Resource = preload("res://Assets/GUI/MapIcons/map2.png")
const MAP_3: Resource = preload("res://Assets/GUI/MapIcons/map3.png")

func _process(_delta: float) -> void:
	var world_selector: WorldSelector = get_tree().get_first_node_in_group("WorldSelector")
	if world_selector == null:
		return
	
	if multiplayer.is_server():
		ready_count.text = str(world_selector.readyCount)
	
	match world_selector.currentMap:
		1:
			map_pic.texture = MAP_1
		2:
			map_pic.texture = MAP_2
		3:
			map_pic.texture = MAP_3

func _on_quit_button_pressed() -> void:
	if not multiplayer.is_server():
		get_tree().get_first_node_in_group("Client").queue_free()
	get_tree().quit()

func _on_back_to_menu_button_pressed() -> void:
	var main: Control = MAIN_MENU.instantiate()
	get_tree().get_first_node_in_group("Menu").add_child(main)
	if not multiplayer.is_server():
		get_tree().get_first_node_in_group("Client").queue_free()
	queue_free()


func _on_ready_button_pressed() -> void:
	Network.sendPlayerJoined.rpc_id(1)
	ready_button.disabled = true
	var world_selector: WorldSelector = get_tree().get_first_node_in_group("WorldSelector")
	world_selector.readied = true
	
func deleteMenu() -> void:
	queue_free()
