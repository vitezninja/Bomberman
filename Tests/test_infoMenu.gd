extends GutTest

var info_menu: InfoMenu
var menu: CanvasLayer = CanvasLayer.new()
const info_menuPath: PackedScene = preload("res://Scenes/Menus/InfoMenu.tscn")

func before_each() -> void:
	await get_tree().process_frame

func before_all() -> void:
	get_tree().root.add_child(menu)
	menu.add_to_group("Menu")
	info_menu = info_menuPath.instantiate()
	get_tree().root.add_child(info_menu)

func after_all() -> void:
	menu.queue_free()

func test_on_quit_button_pressed() -> void:
	assert_has_method(info_menu, "_on_quit_button_pressed", "Info menu must have this method")
	
func test_on_back_button_pressed() -> void:
	assert_has_method(info_menu, "_on_back_button_pressed", "Info menu must have this method")
	info_menu._on_back_button_pressed()
	gut.p(menu.get_child(0))
	assert_eq(menu.get_child_count(), 1, "This should have one child")
	menu.get_child(0).free()
