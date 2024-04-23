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
	enemy.velocity = Vector2(0,0)
	enemy.previousFrameVelocity = Vector2(0,0)

func test_createAstar() -> void:
	assert_has_method(enemy, "createAstar", "Enemy must have this method")

func test_handleMovement() -> void:
	assert_has_method(enemy, "handleMovement", "Enemy must have this method")
	var beforeVel: Vector2 = enemy.velocity
	enemy.previousFrameVelocity = Vector2(1,0)
	enemy.handleMovement(delta)
	assert_ne(enemy.velocity, beforeVel, "The velocity should change after the function call")
	enemy.velocity = Vector2(0,0)
	enemy.previousFrameVelocity = Vector2(0,0)

func test_doMovement() -> void:
	assert_has_method(enemy, "doMovement", "Enemy must have this method")
	var beforeVel: Vector2 = enemy.velocity
	enemy.previousFrameVelocity = Vector2(1,0)
	enemy.doMovement(enemy.chooseRandomDirection, delta) # params dont matter as it will always call move
	assert_ne(enemy.velocity, beforeVel, "The velocity should change after the function call")
	enemy.velocity = Vector2(0,0)
	enemy.previousFrameVelocity = Vector2(0,0)

func test_move() -> void:
	assert_has_method(enemy, "move", "Enemy must have this method")
	enemy.move(Vector2(1,0), delta)
	assert_eq(enemy.velocity, Vector2(1 * enemy.currentSpeed * (delta * enemy.DELTAMULTIPLIER),0), "The velocity should change after the function call")
	enemy.velocity = Vector2(0,0)
	enemy.previousFrameVelocity = Vector2(0,0)

func test_findClosestPath() -> void:
	assert_has_method(enemy, "findClosestPath", "Enemy must have this method")

func test_phase() -> void:
	assert_has_method(enemy, "phase", "Enemy must have this method")
	enemy.phase(delta)
	assert_eq(enemy.z_index, 3, "This should be 3")
	assert_true(enemy.isPhasing, "This should be true")
	assert_eq(enemy.phaseTimer, enemy.MINPHASETIME, "This should start for the phase delay")
	assert_true(enemy.timer.is_stopped(), "The timer should be stoped")

func test_handlePhasing() -> void:
	assert_has_method(enemy, "handlePhasing", "Enemy must have this method")
	enemy.phaseTimer = 0
	enemy.handlePhasing()
	assert_eq(enemy.z_index, 1, "This should be 1")
	assert_false(enemy.isPhasing, "This should be false")
	assert_false(enemy.timer.is_stopped(), "The timer should be going")

func test_handleAnimation() -> void:
	assert_has_method(enemy, "handleAnimation", "Enemy must have this method")
	enemy.previousFrameVelocity = Vector2(0,0)
	enemy.handleAnimation()
	assert_eq(enemy.sprite.animation, "Idle_Forward", "This should be Idle_Forward because the enemy is looking forward and not moving")
	enemy.velocity = Vector2(0,0)
	enemy.previousFrameVelocity = Vector2(0,0)

func test_hit() -> void:
	assert_has_method(enemy, "hit", "Enemy must have this method")
	enemy.hit()
	assert_eq(enemy.sprite.animation, "Death", "This should be Death because the enemy got hit")

func test_changeColor() -> void:
	assert_has_method(enemy, "changeColor", "Enemy must have this method")
	assert_eq(enemy.sprite.modulate, Color(1,1,1), "This is the default color for id 0")

func test_setSpeed() -> void:
	assert_has_method(enemy, "setSpeed", "Enemy must have this method")
	assert_eq(enemy.currentSpeed, enemy.NORMALSPEED, "This is the default speed for id 0")

func test_on_hitbox_area_shape_entered() -> void:
	assert_has_method(enemy, "_on_hitbox_area_shape_entered", "Enemy must have this method")

func test_on_timer_timeout() -> void:
	assert_has_method(enemy, "_on_timer_timeout", "Enemy must have this method")
	enemy._on_timer_timeout()
	assert_ne(enemy.previousFrameVelocity, Vector2(0,0), "This should be in one of the directions as the enemy can't be stationary")
	enemy.velocity = Vector2(0,0)
	enemy.previousFrameVelocity = Vector2(0,0)

func test_findClosestPlayer() -> void:
	assert_has_method(enemy, "findClosestPlayer", "Enemy must have this method")

func test_makeSolids() -> void:
	assert_has_method(enemy, "makeSolids", "Enemy must have this method")

func test_makeWallsSolid() -> void:
	assert_has_method(enemy, "makeWallsSolid", "Enemy must have this method")

func test_makeObjectsSolid() -> void:
	assert_has_method(enemy, "makeObjectsSolid", "Enemy must have this method")
