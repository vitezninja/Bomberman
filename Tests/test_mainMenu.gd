extends GutTest

var main_menu: MainMenu
var menu: CanvasLayer = CanvasLayer.new()
const main_menuPath: PackedScene = preload("res://Scenes/Menus/MainMenu.tscn")

func before_each() -> void:
	await get_tree().process_frame
	main_menu = main_menuPath.instantiate()
	get_tree().get_first_node_in_group("Menu").add_child(main_menu)

func after_each() -> void:
	if is_instance_valid(main_menu):
		main_menu.queue_free()
	for node in menu.get_children():
		node.queue_free()

func before_all() -> void:
	menu.add_to_group("Menu")
	get_tree().root.add_child(menu)

func after_all() -> void:
	menu.queue_free()

func test_on_quit_button_pressed() -> void:
	assert_has_method(main_menu, "_on_quit_button_pressed", "MainMenu must have this method")
	
func test_on_play_button_pressed() -> void:
	assert_has_method(main_menu, "_on_play_button_pressed", "MainMenu must have this method")
	main_menu._on_play_button_pressed()
	await get_tree().process_frame
	assert_eq(menu.get_child_count(), 1, "This should have one child")
	
func test_on_info_button_pressed() -> void:
	assert_has_method(main_menu, "_on_info_button_pressed", "MainMenu must have this method")
	main_menu._on_info_button_pressed()
	await get_tree().process_frame
	assert_eq(menu.get_child_count(), 1, "This should have one child")

func test_on_credits_button_pressed() -> void:
	assert_has_method(main_menu, "_on_credits_button_pressed", "MainMenu must have this method")
	main_menu._on_credits_button_pressed()
	await get_tree().process_frame
	assert_eq(menu.get_child_count(), 1, "This should have one child")
	
func test_on_keybinds_button_pressed() -> void:
	assert_has_method(main_menu, "_on_keybinds_button_pressed", "MainMenu must have this method")
	main_menu._on_keybinds_button_pressed()
	await get_tree().process_frame
	assert_eq(menu.get_child_count(), 1, "This should have one child")
