extends GutTest

var main_menu: MainMenu
var menu: CanvasLayer = CanvasLayer.new()
const main_menuPath: PackedScene = preload("res://Scenes/Menus/MainMenu.tscn")

func before_each() -> void:
	await get_tree().process_frame

func before_all() -> void:
	get_tree().root.add_child(menu)
	menu.add_to_group("Menu")
	set_mainMenu()

func after_all() -> void:
	menu.queue_free()
	
func set_mainMenu() -> void:
	if main_menu != null:
		return
	main_menu = main_menuPath.instantiate()
	get_tree().root.add_child(main_menu)

func test_on_quit_button_pressed() -> void:
	assert_has_method(main_menu, "_on_quit_button_pressed", "Main menu must have this method")
	
func test_on_play_button_pressed() -> void:
	set_mainMenu()
	assert_has_method(main_menu, "_on_play_button_pressed", "Main menu must have this method")
	main_menu._on_play_button_pressed()
	assert_eq(menu.get_child_count(), 1, "This should have one child")
	menu.get_child(0).free()
	
func test_on_info_button_pressed() -> void:
	set_mainMenu()
	assert_has_method(main_menu, "_on_info_button_pressed", "Main menu must have this method")
	main_menu._on_info_button_pressed()
	assert_eq(menu.get_child_count(), 1, "This should have one child")
	menu.get_child(0).free()

func test_on_credits_button_pressed() -> void:
	set_mainMenu()
	assert_has_method(main_menu, "_on_credits_button_pressed", "Main menu must have this method")
	main_menu._on_credits_button_pressed()
	assert_eq(menu.get_child_count(), 1, "This should have one child")
	menu.get_child(0).free()
	
func test_on_keybinds_button_pressed() -> void:
	set_mainMenu()
	assert_has_method(main_menu, "_on_keybinds_button_pressed", "Main menu must have this method")
	main_menu._on_keybinds_button_pressed()
	assert_eq(menu.get_child_count(), 1, "This should have one child")
	menu.get_child(0).free()
