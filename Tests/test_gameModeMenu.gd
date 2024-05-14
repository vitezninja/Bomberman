extends GutTest

var gameModeMenu: GameModeMenu
var menu: CanvasLayer = CanvasLayer.new()
const gameModeMenuPath: PackedScene = preload("res://Scenes/Menus/GameModeMenu.tscn")

func before_each() -> void:
	await get_tree().process_frame
	gameModeMenu = gameModeMenuPath.instantiate()
	get_tree().get_first_node_in_group("Menu").add_child(gameModeMenu)

func after_each() -> void:
	if is_instance_valid(gameModeMenu):
		gameModeMenu.queue_free()
	for node in menu.get_children():
		node.queue_free()

func before_all() -> void:
	menu.add_to_group("Menu")
	get_tree().root.add_child(menu)

func after_all() -> void:
	menu.queue_free()

func test_on_quit_button_pressed() -> void:
	assert_has_method(gameModeMenu, "_on_quit_button_pressed", "GameModeMenu must have this method")
	
func test_on_back_button_pressed() -> void:
	assert_has_method(gameModeMenu, "_on_back_button_pressed", "GameModeMenu must have this method")
	gameModeMenu._on_back_button_pressed()
	await get_tree().process_frame
	assert_eq(menu.get_child_count(), 1, "This should have one child")

func test_on_offline_pressed() -> void:
	assert_has_method(gameModeMenu, "_on_offline_pressed", "GameModeMenu must have this method")
	gameModeMenu._on_offline_pressed()
	await get_tree().process_frame
	assert_eq(menu.get_child_count(), 1, "This should have one child")

func test_on_online_pressed() -> void:
	assert_has_method(gameModeMenu, "_on_online_pressed", "GameModeMenu must have this method")
	gameModeMenu._on_online_pressed()
	await get_tree().process_frame
	assert_eq(menu.get_child_count(), 1, "This should have one child")
