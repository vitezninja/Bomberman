class_name InfoTest
extends Control

@onready var quit_button = $MarginContainer/VBoxContainer/HBoxContainer/QuitButton as Button
@onready var back_button = $MarginContainer/VBoxContainer/HBoxContainer5/BackButton as Button
@export var main_menu = load("res://Scenes/Menus/MainMenuTest.tscn") as PackedScene

func _ready():
	back_button.button_down.connect(on_back_pressed)
	quit_button.button_down.connect(on_exit_pressed)


func on_back_pressed() -> void:
	get_tree().change_scene_to_packed(main_menu)


func on_exit_pressed() -> void:
	get_tree().quit()
