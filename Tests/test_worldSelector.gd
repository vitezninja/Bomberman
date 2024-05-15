extends GutTest

var worldSelector: WorldSelector
const worldSelectorPath: PackedScene = preload("res://Scenes/WorldSelector.tscn")

func before_each() -> void:
	await get_tree().process_frame
	worldSelector = worldSelectorPath.instantiate()
	get_tree().root.add_child(worldSelector)

func after_each() -> void:
	if is_instance_valid(worldSelector):
		worldSelector.queue_free()

func test_loadMode():
	assert_has_method(worldSelector, "loadMode", "WorldSelector must have this method")

func test_loadPlayers():
	assert_has_method(worldSelector, "loadPlayers", "WorldSelector must have this method")

func test_loadMap():
	assert_has_method(worldSelector, "loadMap", "WorldSelector must have this method")
	worldSelector.loadMap()
	assert_eq(worldSelector.get_child_count(), 1, "This should have one child")

func test_startGame():
	assert_has_method(worldSelector, "startGame", "WorldSelector must have this method")
	worldSelector.startGame()
	assert_eq(worldSelector.get_child_count(), 1, "This should have one child")

func test_hasGameLocked():
	assert_has_method(worldSelector, "hasGameLocked", "WorldSelector must have this method")
	worldSelector.startGame()
	var value = worldSelector.hasGameLocked()
	assert_false(value, "This should be false")

func test_hasGameEnded():
	assert_has_method(worldSelector, "hasGameEnded", "WorldSelector must have this method")
	worldSelector.startGame()
	var value = worldSelector.hasGameEnded()
	assert_true(value, "This should be true")

func test_lockGame():
	assert_has_method(worldSelector, "lockGame", "WorldSelector must have this method")
	worldSelector.startGame()
	worldSelector.lockGame()
	var value = worldSelector.hasGameLocked()
	assert_false(value, "This should be false")

func test_endGame():
	assert_has_method(worldSelector, "endGame", "WorldSelector must have this method")
	worldSelector.startGame()
	worldSelector.endGame()
	var value = worldSelector.hasGameEnded()
	assert_true(value, "This should be true")
