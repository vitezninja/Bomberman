extends GutTest

var mapSelectorMenu: MapSelectorMenu
var menu: CanvasLayer = CanvasLayer.new()
const MapSelectorMenuPath: PackedScene = preload("res://Scenes/Menus/MapSelectorMenu.tscn")

func before_each() -> void:
	await get_tree().process_frame
	mapSelectorMenu = MapSelectorMenuPath.instantiate()
	get_tree().get_first_node_in_group("Menu").add_child(mapSelectorMenu)

func after_each() -> void:
	if is_instance_valid(mapSelectorMenu):
		mapSelectorMenu.queue_free()
	for node in menu.get_children():
		node.queue_free()

func before_all() -> void:
	menu.add_to_group("Menu")
	get_tree().root.add_child(menu)

func after_all() -> void:
	menu.queue_free()

func test_on_quit_button_pressed() -> void:
	assert_has_method(mapSelectorMenu, "_on_quit_button_pressed", "MapSelectorMenu must have this method")
	
func test_on_back_button_pressed() -> void:
	assert_has_method(mapSelectorMenu, "_on_back_button_pressed", "MapSelectorMenu must have this method")
	mapSelectorMenu._on_back_button_pressed()
	await get_tree().process_frame
	assert_eq(menu.get_child_count(), 1, "This should have one child")

func test_on_start_button_pressed() -> void:
	assert_has_method(mapSelectorMenu, "_on_start_button_pressed", "MapSelectorMenu must have this method")
	mapSelectorMenu._on_start_button_pressed()
	await get_tree().process_frame
	assert_eq(menu.get_child_count(), 1, "This should have one child")
