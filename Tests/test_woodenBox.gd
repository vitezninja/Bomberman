extends GutTest

var woodenBox: WoodenBox
const boxPath: PackedScene = preload("res://Scenes/WoodenBox.tscn")

func before_each() -> void:
	await get_tree().process_frame
	woodenBox = boxPath.instantiate()
	get_tree().root.add_child(woodenBox)

func after_each() -> void:
	if not is_instance_valid(woodenBox):
		return
	woodenBox.free()

func test_dropPowerUp() -> void:
	assert_has_method(woodenBox, "dropPowerUp", "WoodenBox must have this method")

func test_destroy() -> void:
	assert_has_method(woodenBox, "destroy", "WoodenBox must have this method")
