extends Control
class_name GameOverMenu3Players

const MAIN_MENU: PackedScene = preload("res://Scenes/Menus/MainMenu.tscn")
@onready var player_1_wins = %Player1Wins
@onready var player_2_wins = %Player2Wins
@onready var player_3_wins = %Player3Wins
@onready var round_count = %RoundCount
@onready var next_round_button = %NextRoundButton


func _ready():
	var world_selector: WorldSelector = get_tree().get_first_node_in_group("WorldSelector")
	
	round_count.text = str(world_selector.gameCount)
	
	match world_selector.currentWinner:
		Player.playerEnum.Player1:
			pass
		Player.playerEnum.Player2:
			pass
		Player.playerEnum.Player3:
			pass
		_:
			return
	
	if world_selector.gameCount > 0:
		next_round_button.visible = true
		next_round_button.disabled = false
	else:
		next_round_button.visible = false
		next_round_button.disabled = true

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_back_to_menu_button_pressed():
	var main: Control = MAIN_MENU.instantiate()
	get_tree().get_first_node_in_group("Menu").add_child(main)
	queue_free()


func _on_next_round_button_pressed():
	var world_selector: WorldSelector = get_tree().get_first_node_in_group("WorldSelector")
	
	if world_selector == null:
		return
		
	world_selector.startGame()
	queue_free()

