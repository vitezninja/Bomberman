extends GutTest

var credits_menu: CreditsMenu
var menu: CanvasLayer = CanvasLayer.new()
const credits_menuPath: PackedScene = preload("res://Scenes/Menus/CreditsMenu.tscn")

func before_each() -> void:
	await get_tree().process_frame
	credits_menu = credits_menuPath.instantiate()
	get_tree().get_first_node_in_group("Menu").add_child(credits_menu)

func after_each() -> void:
	if is_instance_valid(credits_menu):
		credits_menu.queue_free()
	for node in menu.get_children():
		node.queue_free()

func before_all() -> void:
	menu.add_to_group("Menu")
	get_tree().root.add_child(menu)

func after_all() -> void:
	menu.queue_free()

func test_on_quit_button_pressed() -> void:
	assert_has_method(credits_menu, "_on_quit_button_pressed", "CreditsMenu must have this method")
	
func test_on_back_button_pressed() -> void:
	assert_has_method(credits_menu, "_on_back_button_pressed", "CreditsMenu must have this method")
	credits_menu._on_back_button_pressed()
	await get_tree().process_frame
	assert_eq(menu.get_child_count(), 1, "This should have one child")
