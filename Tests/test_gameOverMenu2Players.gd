extends GutTest

var gameOverMenu2Players: GameOverMenu2Players
var menu: CanvasLayer = CanvasLayer.new()
const gameOverMenu2PlayersPath: PackedScene = preload("res://Scenes/Menus/GameOverMenu2Players.tscn")

func before_each() -> void:
	await get_tree().process_frame
	gameOverMenu2Players = gameOverMenu2PlayersPath.instantiate()
	get_tree().get_first_node_in_group("Menu").add_child(gameOverMenu2Players)

func after_each() -> void:
	if is_instance_valid(gameOverMenu2Players):
		gameOverMenu2Players.queue_free()
	for node in menu.get_children():
		node.queue_free()

func before_all() -> void:
	menu.add_to_group("Menu")
	get_tree().root.add_child(menu)

func after_all() -> void:
	menu.queue_free()

func test_on_quit_button_pressed() -> void:
	assert_has_method(gameOverMenu2Players, "_on_quit_button_pressed", "GameOverMenu2Players must have this method")
	
func test_on_back_button_pressed() -> void:
	assert_has_method(gameOverMenu2Players, "_on_back_to_menu_button_pressed", "GameOverMenu2Players must have this method")
	gameOverMenu2Players._on_back_to_menu_button_pressed()
	await get_tree().process_frame
	assert_eq(menu.get_child_count(), 1, "This should have one child")

func test_on_next_round_button_pressed() -> void:
	assert_has_method(gameOverMenu2Players, "_on_next_round_button_pressed", "GameOverMenu2Players must have this method")
	gameOverMenu2Players._on_next_round_button_pressed()
	await get_tree().process_frame
	assert_eq(menu.get_child_count(), 1, "This should have one child")
