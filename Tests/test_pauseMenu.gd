extends GutTest

var pauseMenu: PauseMenu
var menu: CanvasLayer = CanvasLayer.new()
const pauseMenuPath: PackedScene = preload("res://Scenes/Menus/PauseMenu.tscn")

func before_each() -> void:
	await get_tree().process_frame
	pauseMenu = pauseMenuPath.instantiate()
	get_tree().get_first_node_in_group("Menu").add_child(pauseMenu)

func after_each() -> void:
	if is_instance_valid(pauseMenu):
		pauseMenu.queue_free()
	for node in menu.get_children():
		node.queue_free()

func before_all() -> void:
	menu.add_to_group("Menu")
	get_tree().root.add_child(menu)

func after_all() -> void:
	menu.queue_free()

func test_disableButtons() -> void:
	assert_has_method(pauseMenu, "disableButtons", "PauseMenu must have this method")
	
func test_resume() -> void:
	assert_has_method(pauseMenu, "resume", "PauseMenu must have this method")

func test_pause() -> void:
	assert_has_method(pauseMenu, "pause", "PauseMenu must have this method")

func test_handleEsc() -> void:
	assert_has_method(pauseMenu, "handleEsc", "PauseMenu must have this method")

func test_on_resume_pressed() -> void:
	assert_has_method(pauseMenu, "_on_resume_pressed", "PauseMenu must have this method")

func test_on_back_to_menu_pressed() -> void:
	assert_has_method(pauseMenu, "_on_back_to_menu_pressed", "PauseMenu must have this method")

func test_on_quit_pressed() -> void:
	assert_has_method(pauseMenu, "_on_resume_pressed", "PauseMenu must have this method")
