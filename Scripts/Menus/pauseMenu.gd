extends Control
class_name PauseMenu

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var resume_button: Button = %Resume
@onready var back_button: Button = %Back
@onready var quit_button: Button = %Quit
const MAIN_MENU: PackedScene = preload("res://Scenes/Menus/MainMenu.tscn")

func _ready() -> void:
	disableButtons(true)
	animation_player.play("RESET")

func _process(_delta: float) -> void:
	handleEsc() 

func disableButtons(value: bool) -> void:
	resume_button.disabled = value
	back_button.disabled = value
	quit_button.disabled = value

func resume() -> void:
	get_tree().paused = false
	disableButtons(true)
	animation_player.play_backwards("blur")

func pause() -> void:
	if get_tree().get_first_node_in_group("WorldSelector").get_child_count() == 0:
		return
	get_tree().paused = true
	disableButtons(false)
	animation_player.play("blur")

func handleEsc() -> void:
	if Input.is_action_just_pressed("pause") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("pause") and get_tree().paused == true:
		resume()

func _on_resume_pressed() -> void:
	resume()

func _on_back_to_menu_pressed() -> void:
	resume()
	var main: Control = MAIN_MENU.instantiate()
	get_tree().get_first_node_in_group("Menu").add_child(main)
	var world_selector: Node = get_tree().get_first_node_in_group("WorldSelector")
	world_selector.endGame()

func _on_quit_pressed() -> void:
	get_tree().quit()
