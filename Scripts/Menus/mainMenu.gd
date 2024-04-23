extends Control
class_name MainMenu

@onready var keybinds_menu: PackedScene = load("res://Scenes/Menus/KeybindsMenu.tscn")
@onready var game_mode_menu: PackedScene = load("res://Scenes/Menus/GameModeMenu.tscn")  
@onready var credits_menu: PackedScene = load("res://Scenes/Menus/CreditsMenu.tscn")
@onready var info_menu: PackedScene = load("res://Scenes/Menus/InfoMenu.tscn")

func _ready() -> void:
	KeyConfig.loadData()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_play_button_pressed() -> void:
	var gamemode = game_mode_menu.instantiate()
	get_tree().get_first_node_in_group("Menu").add_child(gamemode)
	queue_free()

func _on_info_button_pressed() -> void:
	var info: Control = info_menu.instantiate()
	get_tree().get_first_node_in_group("Menu").add_child(info)
	queue_free()

func _on_credits_button_pressed() -> void:
	var credits: Control = credits_menu.instantiate()
	get_tree().get_first_node_in_group("Menu").add_child(credits)
	queue_free()

func _on_keybinds_button_pressed() -> void:
	var keybinds: Control = keybinds_menu.instantiate()
	get_tree().get_first_node_in_group("Menu").add_child(keybinds)
	queue_free()
