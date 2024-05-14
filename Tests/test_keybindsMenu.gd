extends GutTest

var keybindsMenu: KeybindsMenu
var menu: CanvasLayer = CanvasLayer.new()
const keybindsMenuPath: PackedScene = preload("res://Scenes/Menus/KeybindsMenu.tscn")

func before_each() -> void:
	await get_tree().process_frame
	keybindsMenu = keybindsMenuPath.instantiate()
	get_tree().get_first_node_in_group("Menu").add_child(keybindsMenu)

func after_each() -> void:
	if is_instance_valid(keybindsMenu):
		keybindsMenu.queue_free()
	for node in menu.get_children():
		node.queue_free()

func before_all() -> void:
	menu.add_to_group("Menu")
	get_tree().root.add_child(menu)

func after_all() -> void:
	menu.queue_free()

func test_on_quit_button_pressed() -> void:
	assert_has_method(keybindsMenu, "_on_quit_button_pressed", "KeybindsMenu must have this method")
	
func test_on_back_button_pressed() -> void:
	assert_has_method(keybindsMenu, "_on_back_button_pressed", "KeybindsMenu must have this method")
	keybindsMenu._on_back_button_pressed()
	await get_tree().process_frame
	assert_eq(menu.get_child_count(), 1, "This should have one child")

func test_on_reset_to_default_pressed() -> void:
	assert_has_method(keybindsMenu, "_on_reset_to_default_pressed", "KeybindsMenu must have this method")
