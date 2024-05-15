extends GutTest

var bombEffect: BombEffect
const bombEffectPath: PackedScene = preload("res://Scenes/BombEffect.tscn")

func before_each() -> void:
	await get_tree().process_frame
	bombEffect = bombEffectPath.instantiate()
	get_tree().root.add_child(bombEffect)

func after_each() -> void:
	if is_instance_valid(bombEffect):
		bombEffect.queue_free()

func test_expand():
	assert_has_method(bombEffect, "expand", "BombEffect must have this method")

func test_chooseCenter():
	assert_has_method(bombEffect, "chooseCenter", "BombEffect must have this method")

func test_checkEnd():
	assert_has_method(bombEffect, "checkEnd", "BombEffect must have this method")
	bombEffect.checkEnd()
	assert_eq(bombEffect.ticks, 1, "This should be 1")

func test_on_timer_timeout():
	assert_has_method(bombEffect, "_on_timer_timeout", "BombEffect must have this method")
	bombEffect._on_timer_timeout()
	assert_eq(bombEffect.ticks, 1, "This should be 1")

func test_expandSide():
	assert_has_method(bombEffect, "expandSide", "BombEffect must have this method")

func test_addMiddle():
	assert_has_method(bombEffect, "addMiddle", "BombEffect must have this method")

func test_on_hitbox_center_area_shape_entered():
	assert_has_method(bombEffect, "_on_hitbox_center_area_shape_entered", "BombEffect must have this method")

func test_on_hitbox_top_area_shape_entered():
	assert_has_method(bombEffect, "_on_hitbox_top_area_shape_entered", "BombEffect must have this method")

func test_on_hitbox_right_area_shape_entered():
	assert_has_method(bombEffect, "_on_hitbox_right_area_shape_entered", "BombEffect must have this method")

func test_on_hitbox_bottom_area_shape_entered():
	assert_has_method(bombEffect, "_on_hitbox_bottom_area_shape_entered", "BombEffect must have this method")

func test_on_hitbox_left_area_shape_entered():
	assert_has_method(bombEffect, "_on_hitbox_left_area_shape_entered", "BombEffect must have this method")

func test_hit():
	assert_has_method(bombEffect, "hit", "BombEffect must have this method")

func test_expodeIfBox():
	assert_has_method(bombEffect, "expodeIfBox", "BombEffect must have this method")
