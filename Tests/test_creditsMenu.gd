extends GutTest

var credits_menu: CreditsMenu
var menu: CanvasLayer = CanvasLayer.new()
const credits_menuPath: PackedScene = preload("res://Scenes/Menus/CreditsMenu.tscn")

func before_each() -> void:
	await get_tree().process_frame

func before_all() -> void:
	get_tree().root.add_child(menu)
	menu.add_to_group("Menu")
	credits_menu = credits_menuPath.instantiate()
	get_tree().root.add_child(credits_menu)

func after_all() -> void:
	menu.queue_free()

func test_on_quit_button_pressed() -> void:
	assert_has_method(credits_menu, "_on_quit_button_pressed", "Credits menu must have this method")
	
func test_on_back_button_pressed() -> void:
	assert_has_method(credits_menu, "_on_back_button_pressed", "Credits menu must have this method")
	credits_menu._on_back_button_pressed()
	assert_eq(menu.get_child_count(), 1, "This should have one child")
	menu.get_child(0).free()
