extends GutTest

var powerup: PowerUp
const powerupPath: PackedScene = preload("res://Scenes/PowerUp.tscn")

func before_each() -> void:
	await get_tree().process_frame
	powerup = powerupPath.instantiate()
	get_tree().root.add_child(powerup)

func after_each() -> void:
	if not is_instance_valid(powerup):
		return
	powerup.free()

func test_handleSprite() -> void:
	assert_has_method(powerup, "handleSprite", "PowerUp must have this method")

func test_on_hitbox_body_entered() -> void:
	assert_has_method(powerup, "_on_hitbox_body_entered", "PowerUp must have this method")


