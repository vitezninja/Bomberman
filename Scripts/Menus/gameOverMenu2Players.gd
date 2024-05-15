extends Control
class_name GameOverMenu2Players

const MAIN_MENU: PackedScene = preload("res://Scenes/Menus/MainMenu.tscn")
@onready var player_1_wins: Label = %Player1Wins
@onready var player_2_wins: Label = %Player2Wins
@onready var round_count: Label = %RoundCount
@onready var next_round_button: Button = %NextRoundButton
@onready var player_1_bombs: Label = %Player1Bombs
@onready var player_2_bombs: Label = %Player2Bombs
@onready var player_1_power_ups: Label = %Player1PowerUps
@onready var player_2_power_ups: Label = %Player2PowerUps


func _ready() -> void:
	var world_selector: WorldSelector = get_tree().get_first_node_in_group("WorldSelector")
	if world_selector == null:
		return
	
	round_count.text = str(world_selector.gameCount)
	
	player_1_wins.text = str(GameStats.winns[0])
	player_2_wins.text = str(GameStats.winns[1])
	player_1_bombs.text = str(GameStats.bombs[0])
	player_2_bombs.text = str(GameStats.bombs[1])
	player_1_power_ups.text = str(GameStats.powerups[0])
	player_2_power_ups.text = str(GameStats.powerups[1])
	
	if world_selector.gameCount > 0:
		next_round_button.visible = true
		next_round_button.disabled = false
	else:
		next_round_button.visible = false
		next_round_button.disabled = true

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_back_to_menu_button_pressed() -> void:
	var main: Control = MAIN_MENU.instantiate()
	get_tree().get_first_node_in_group("Menu").add_child(main)
	queue_free()


func _on_next_round_button_pressed() -> void:
	var world_selector: WorldSelector = get_tree().get_first_node_in_group("WorldSelector")
	if world_selector == null:
		return
		
	world_selector.startGame()
	queue_free()
