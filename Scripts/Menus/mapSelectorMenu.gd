extends Control
class_name MapSelectorMenu

@onready var offline_menu: PackedScene = load("res://Scenes/Menus/OfflineMenu.tscn")

func _on_back_button_pressed() -> void:
	var offline: Control = offline_menu.instantiate()
	get_tree().get_first_node_in_group("Menu").add_child(offline)
	queue_free()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
