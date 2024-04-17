extends GutTest

var enemy: Enemy
var delta: float = 0.1
const enemyPath: PackedScene = preload("res://Scenes/Enemy.tscn")

func before_all() -> void:
	enemy = enemyPath.instantiate()
	get_tree().root.get_child(0).add_child(enemy)

func after_all() -> void:
	enemy.free()

func test_id() -> void:
	assert_eq(enemy.enemyId, 0, "This should be 0 because we the player still has default Id")

func test_chooseRandomDirection() -> void:
	assert_has_method(enemy, "chooseRandomDirection", "Enemy must have this method")
	enemy.chooseRandomDirection()
	assert_ne(enemy.previousFrameVelocity, Vector2(0,0), "This should be in one of the directions as the enemy can't be stationary")

func test_createAstar() -> void:
	assert_has_method(enemy, "createAstar", "Enemy must have this method")

func test_handleMovement():
	assert_has_method(enemy, "handleMovement", "Enemy must have this method")
	var beforeVel: Vector2 = enemy.velocity
	enemy.handleMovement(delta)
	assert_ne(enemy.velocity, beforeVel, "The velocity should change after the function call")
	enemy.velocity = Vector2(0,0)

func test_doMovement():
	assert_has_method(enemy, "doMovement", "Enemy must have this method")
	var beforeVel: Vector2 = enemy.velocity
	enemy.doMovement(enemy.chooseRandomDirection, delta) # params dont matter as it will always call move
	assert_ne(enemy.velocity, beforeVel, "The velocity should change after the function call")
	enemy.velocity = Vector2(0,0)

func test_move():
	assert_has_method(enemy, "move", "Enemy must have this method")
	enemy.move(Vector2(1,0), delta)
	assert_eq(enemy.velocity, Vector2(1 * enemy.currentSpeed * (delta * enemy.DELTAMULTIPLIER),0), "The velocity should change after the function call")
	enemy.velocity = Vector2(0,0)

func test_findClosestPath():
	assert_has_method(enemy, "findClosestPath", "Enemy must have this method")
