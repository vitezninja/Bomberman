class_name PauseMenu
extends Control

@onready var back = %Back
@onready var resume_button: Button = %Resume
@onready var back_to_menu: Button = %Back
@onready var quit: Button = %Quit
@onready var animation_player: AnimationPlayer = %AnimationPlayer
const MAIN_MENU_TEST = preload("res://Scenes/Menus/MainMenu.tscn")

func _ready():
	animation_player.play("RESET")

func resume():
	get_tree().paused = false
	animation_player.play_backwards("blur")


func pause():
	get_tree().paused = true
	animation_player.play("blur")

func testEsc():
	if Input.is_action_just_pressed("pause") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("pause") and get_tree().paused == true:
		resume()

func _on_resume_pressed():
	resume()


func _on_back_to_menu_pressed():
	resume()
	var main = MAIN_MENU_TEST.instantiate()
	get_tree().get_first_node_in_group("Menu").add_child(main)
	get_tree().get_first_node_in_group("WorldSelector").get_children()[0].queue_free()

func _on_quit_pressed():
	get_tree().quit()
	
func _process(_delta):
	testEsc() 
