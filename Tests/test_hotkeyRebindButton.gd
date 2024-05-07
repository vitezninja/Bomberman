extends GutTest

var hotkeyRebindButton: HotkeyRebindButton
var menu: CanvasLayer = CanvasLayer.new()
const hotkeyRebindButtonPath: PackedScene = preload("res://Scenes/Menus/HotkeyRebindButton.tscn")

func before_each() -> void:
	await get_tree().process_frame
	hotkeyRebindButton = hotkeyRebindButtonPath.instantiate()
	get_tree().get_first_node_in_group("Menu").add_child(hotkeyRebindButton)

func after_each() -> void:
	if is_instance_valid(hotkeyRebindButton):
		hotkeyRebindButton.queue_free()
	for node in menu.get_children():
		node.queue_free()

func before_all() -> void:
	menu.add_to_group("Menu")
	get_tree().root.add_child(menu)

func after_all() -> void:
	menu.queue_free()

func test_set_action_name() -> void:
	assert_has_method(hotkeyRebindButton, "set_action_name", "HotkeyRebindButton must have this method")

func test_set_text_for_key() -> void:
	assert_has_method(hotkeyRebindButton, "set_text_for_key", "HotkeyRebindButton must have this method")

func test_on_action_key_toggled() -> void:
	assert_has_method(hotkeyRebindButton, "_on_action_key_toggled", "HotkeyRebindButton must have this method")

func test_unhandled_key_input() -> void:
	assert_has_method(hotkeyRebindButton, "_unhandled_key_input", "HotkeyRebindButton must have this method")

func test_rebind_action_key() -> void:
	assert_has_method(hotkeyRebindButton, "rebind_action_key", "HotkeyRebindButton must have this method")
