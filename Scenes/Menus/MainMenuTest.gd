class_name MainMenuTest
extends Control

@onready var info_button = $MarginContainer/VBoxContainer/HBoxContainer5/InfoButton as Button
@onready var play_button = $MarginContainer/VBoxContainer/HBoxContainer4/PlayButton as Button
@onready var quit_button = $MarginContainer/VBoxContainer/HBoxContainer/QuitButton as Button
@export var start_level = preload("res://Scenes/Root.tscn") as PackedScene
@export var info_menu = load("res://Scenes/Menus/InfoTest.tscn") as PackedScene

func _ready():
	play_button.button_down.connect(on_play_pressed)
	quit_button.button_down.connect(on_exit_pressed)
	info_button.button_down.connect(on_info_pressed)


func on_play_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)


func on_exit_pressed() -> void:
	get_tree().quit()

func on_info_pressed() -> void:
	get_tree().change_scene_to_packed(info_menu)
