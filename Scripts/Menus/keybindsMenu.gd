extends Control
class_name KeybindsMenu

const MAIN_MENU: PackedScene = preload("res://Scenes/Menus/MainMenu.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
	
func _on_back_button_pressed() -> void:
	var main: Control = MAIN_MENU.instantiate()
	get_tree().get_first_node_in_group("Menu").add_child(main)
	queue_free()


func _on_reset_to_default_pressed() -> void:
	KeyConfig.restoreToDefault()
	for i in get_tree().get_nodes_in_group("hotkey_button"):
		i.set_text_for_key()
