extends Control
class_name OnlineGameOverMenu

const MAIN_MENU: PackedScene = preload("res://Scenes/Menus/MainMenu.tscn")
@onready var player_1_wins: Label = %Player1Wins
@onready var player_2_wins: Label = %Player2Wins
@onready var player_3_wins: Label = %Player3Wins
@onready var player_1_bombs: Label = %Player1Bombs
@onready var player_2_bombs: Label = %Player2Bombs
@onready var player_3_bombs: Label = %Player3Bombs
@onready var player_1_power_ups: Label = %Player1PowerUps
@onready var player_2_power_ups: Label = %Player2PowerUps
@onready var player_3_power_ups: Label = %Player3PowerUps
@onready var ready_button: Button = %ReadyButton
@onready var ready_count: Label = %ReadyCount


func _ready() -> void:
	var world_selector: WorldSelector = get_tree().get_first_node_in_group("WorldSelector")
	if world_selector == null:
		return
	if multiplayer.is_server():
		ready_count.text = str(world_selector.readyCount)
		
	player_1_wins.text = str(GameStats.winns[0])
	player_2_wins.text = str(GameStats.winns[1])
	player_3_wins.text = str(GameStats.winns[2])
	player_1_bombs.text = str(GameStats.bombs[0])
	player_2_bombs.text = str(GameStats.bombs[1])
	player_3_bombs.text = str(GameStats.bombs[2])
	player_1_power_ups.text = str(GameStats.powerups[0])
	player_2_power_ups.text = str(GameStats.powerups[1])
	player_3_power_ups.text = str(GameStats.powerups[2])

func _process(_delta: float) -> void:
	var world_selector: WorldSelector = get_tree().get_first_node_in_group("WorldSelector")
	if world_selector == null:
		return
	if multiplayer.is_server():
		ready_count.text = str(world_selector.readyCount)

func _on_quit_button_pressed() -> void:
	if not multiplayer.is_server():
		get_tree().get_first_node_in_group("Client").queue_free()
	get_tree().quit()

func _on_back_to_menu_button_pressed() -> void:
	var main: Control = MAIN_MENU.instantiate()
	get_tree().get_first_node_in_group("Menu").add_child(main)
	if not multiplayer.is_server():
		get_tree().get_first_node_in_group("Client").queue_free()
	queue_free()


func _on_next_round_button_pressed() -> void:
	var world_selector: WorldSelector = get_tree().get_first_node_in_group("WorldSelector")
	if world_selector == null:
		return
		
	world_selector.startGame()
	queue_free()


func _on_ready_button_pressed() -> void:
	Network.sendPlayerJoined.rpc_id(1)
	ready_button.disabled = true
	var world_selector: WorldSelector = get_tree().get_first_node_in_group("WorldSelector")
	world_selector.readied = true

func deleteMenu() -> void:
	queue_free()
