extends Node2D
class_name WorldSelector

enum gameTypeEnum {Offline, Online}
enum playerCountEnum {Two = 2, Three = 3}
enum mapIdEnum {One = 1, Two = 2, Three = 3, Test = 0}
enum gameStatusEnum {Idle, Running, Locked}

@export var currentMap: mapIdEnum
@export var playerCount: playerCountEnum
@export var gameType: gameTypeEnum
var gameCount: int = 0
var gameStatus: gameStatusEnum
var readyCount: int = 0
var readied: bool = false

const MAIN_MENU: PackedScene = preload("res://Scenes/Menus/MainMenu.tscn")
const test: PackedScene = preload("res://Scenes/Maps/TestWorld.tscn")
const map1: PackedScene = preload("res://Scenes/Maps/Map1.tscn")
const map2: PackedScene = preload("res://Scenes/Maps/Map2.tscn")
const map3: PackedScene = preload("res://Scenes/Maps/Map3.tscn")
const o_map1: PackedScene = preload("res://Scenes/Online/OnlineMap1.tscn")
const o_map2: PackedScene = preload("res://Scenes/Online/OnlineMap2.tscn")
const o_map3: PackedScene = preload("res://Scenes/Online/OnlineMap3.tscn")
const GAME_OVER_MENU_2_PLAYERS: PackedScene = preload("res://Scenes/Menus/GameOverMenu2Players.tscn")
const GAME_OVER_MENU_3_PLAYERS: PackedScene = preload("res://Scenes/Menus/GameOverMenu3Players.tscn")
const ONLINE_GAME_OVER_MENU: PackedScene = preload("res://Scenes/Online/OnlineGameOverMenu.tscn")

var currentMapNode: Node

func _physics_process(delta: float) -> void:
	
	if not multiplayer.is_server():
		return
	
	match gameStatus:
		gameStatusEnum.Idle:
			if gameType == gameTypeEnum.Online:
				Network.sendMapNumber.rpc(currentMap)
				Network.sendPlayerCount.rpc(readyCount)
			
				if readyCount == 3:
					startGame()
					Network.startGame.rpc()
					readyCount = 0
				
		gameStatusEnum.Running:
			if hasGameLocked():
				lockGame()
		gameStatusEnum.Locked:
			if hasGameEnded():
				endGame()
				
				if gameType == gameTypeEnum.Online:
					var online_game_over = ONLINE_GAME_OVER_MENU.instantiate()
					get_tree().get_first_node_in_group("Menu").add_child(online_game_over, true)
					return
				
				if playerCount == 2:
					var game_over_2 = GAME_OVER_MENU_2_PLAYERS.instantiate()
					get_tree().get_first_node_in_group("Menu").add_child(game_over_2)
				elif playerCount == 3:
					var game_over_3 = GAME_OVER_MENU_3_PLAYERS.instantiate()
					get_tree().get_first_node_in_group("Menu").add_child(game_over_3)

func loadMode() -> void:
	match gameType:
		gameTypeEnum.Offline:
			return
		gameTypeEnum.Online:
			loadMap()
			onlineLoadPlayers()
			return

func loadPlayers() -> void:
	randomize()
	
	var players: Array[Node] = get_tree().get_nodes_in_group("Player")
	players.shuffle()
	
	match playerCount:
		playerCountEnum.Two:
			players[0].setId(Player.playerEnum.Player1)
			players[1].setId(Player.playerEnum.Player2)
			players[2].queue_free()
			players[3].queue_free()
		playerCountEnum.Three:
			players[0].setId(Player.playerEnum.Player1)
			players[1].setId(Player.playerEnum.Player2)
			players[2].setId(Player.playerEnum.Player3)
			players[3].queue_free()
			
func onlineLoadPlayers() -> void:
	randomize()
	
	var players: Array[Node] = get_tree().get_nodes_in_group("Player")
	players.shuffle()
	
	players[0].setId(OnlinePlayer.playerEnum.Player1)
	players[1].setId(OnlinePlayer.playerEnum.Player2)
	players[2].setId(OnlinePlayer.playerEnum.Player3)
	players[3].queue_free()

func loadMap() -> void:
	match currentMap:
		mapIdEnum.One:
			if gameType == gameTypeEnum.Online:
				currentMapNode = o_map1.instantiate()
			else:
				currentMapNode = map1.instantiate()
		mapIdEnum.Two:
			if gameType == gameTypeEnum.Online:
				currentMapNode = o_map2.instantiate()
			else:
				currentMapNode = map2.instantiate()
		mapIdEnum.Three:
			if gameType == gameTypeEnum.Online:
				currentMapNode = o_map3.instantiate()
			else:
				currentMapNode = map3.instantiate()
		mapIdEnum.Test:
			currentMapNode = test.instantiate()
	add_child(currentMapNode)
	
	
func loadLobby():
	var rng = RandomNumberGenerator.new()
	currentMap = rng.randi_range(1, 3)

func startGame() -> void:
	loadMode()
	if gameType != gameTypeEnum.Online:
		loadMap()
		loadPlayers()
	
	gameStatus = gameStatusEnum.Running
	GameStats.newGame()

func hasGameLocked() -> bool:
	var players: Array[Node] = get_tree().get_nodes_in_group("Player")
	return players.size() < 2

func hasGameEnded() -> bool:
	var bombs: Array[Node] = get_tree().get_nodes_in_group("Bomb")
	if bombs.size() > 0:
		return false
	var explosions: Array[Node] = get_tree().get_nodes_in_group("BombEffect")
	if explosions.size() > 0:
		return false
	return true

func lockGame() -> void:
	gameStatus = gameStatusEnum.Locked
	var bombs: Array[Node] = get_tree().get_first_node_in_group("Bombs").get_children()
	for bomb in bombs:
		if not bomb.automaticDetonation and bomb.timer.is_stopped():
			bomb.startExploding()

func endGame():
	var player: Player = get_tree().get_first_node_in_group("Player")
	if player != null:
		GameStats.addWin(player.playerId)
	currentMapNode.queue_free()
	currentMapNode = null
	gameStatus = gameStatusEnum.Idle
	gameCount -= 1
	
