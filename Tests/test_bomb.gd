extends GutTest

var bomb: Bomb
const bombPath: PackedScene = preload("res://Scenes/Bomb.tscn")

func before_each() -> void:
	await get_tree().process_frame
	bomb = bombPath.instantiate()
	get_tree().root.add_child(bomb)

func after_each() -> void:
	if is_instance_valid(bomb):
		bomb.queue_free()

func test_on_area_2d_body_exited():
	assert_has_method(bomb, "_on_area_2d_body_exited", "Bomb must have this method")
	bomb._on_area_2d_body_exited(null)
	await get_tree().process_frame
	assert_eq(bomb.collision.disabled, false, "This should be false")

func test_on_hitbox_area_shape_entered():
	assert_has_method(bomb, "_on_hitbox_area_shape_entered", "Bomb must have this method")

func test_enableCollision():
	assert_has_method(bomb, "enableCollision", "Bomb must have this method")
	bomb.enableCollision()
	assert_eq(bomb.collision.disabled, false, "This should be false")

func test_timeOut():
	assert_has_method(bomb, "timeOut", "Bomb must have this method")

func test_startExploding():
	assert_has_method(bomb, "startExploding", "Bomb must have this method")

func test_explode():
	assert_has_method(bomb, "explode", "Bomb must have this method")

func test_chainExplod():
	assert_has_method(bomb, "chainExplod", "Bomb must have this method")

func test_createEffect():
	assert_has_method(bomb, "createEffect", "Bomb must have this method")

func test__on_timer_timeout():
	assert_has_method(bomb, "_on_timer_timeout", "Bomb must have this method")
