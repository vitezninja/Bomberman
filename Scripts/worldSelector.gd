extends Node2D
class_name WorldSelector

enum gameTypeEnum {Offline, Online}
enum playerCountEnum {Two = 2, Three = 3}
enum mapIdEnum {One = 1, Two = 2, Three = 3, Test = 0}
enum gameStatusEnum {Idle, Running, Locked}

@export var currentMap: mapIdEnum
@export var playerCount: playerCountEnum
@export var gameType: gameTypeEnum
var gameStatus: gameStatusEnum

const test: PackedScene = preload("res://Scenes/Maps/TestWorld.tscn")
#const map1: PackedScene = preload("res://Scenes/Maps/")
#const map2: PackedScene = preload("res://Scenes/Maps/")
#&const map3: PackedScene = preload("res://Scenes/Maps/")

var currentMapNode: Node

func _physics_process(delta: float) -> void:
	match gameStatus:
		gameStatusEnum.Running:
			if hasGameLocked():
				lockGame()
		gameStatusEnum.Locked:
			if hasGameEnded():
				endGame()

func loadMode() -> void:
	match gameType:
		gameTypeEnum.Offline:
			pass
		gameTypeEnum.Online:
			pass

func loadPlayers() -> void:
	match playerCount:
		playerCountEnum.Two:
			pass
		playerCountEnum.Three:
			pass

func loadMap() -> void:
	match currentMap:
		mapIdEnum.One:
			#map = map1.instantiate()
			pass
		mapIdEnum.Two:
			#map = map2.instantiate()
			pass
		mapIdEnum.Three:
			#map = map3.instantiate()
			pass
		mapIdEnum.Test:
			currentMapNode = test.instantiate()
	add_child(currentMapNode)

func startGame() -> void:
	loadMode()
	if gameType != gameTypeEnum.Online:
		loadMap()
		loadPlayers()
	
	gameStatus = gameStatusEnum.Running

func hasGameLocked() -> bool:
	var players: Array[Node] = get_tree().get_nodes_in_group("Player")
	return players.size() > 1

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

func endGame() -> Player.playerEnum:
	var winner: Player.playerEnum
	var player: Player = get_tree().get_first_node_in_group("Player")
	if player != null:
		winner = player.playerId
	currentMapNode.queue_free()
	currentMapNode = null
	gameStatus = gameStatusEnum.Idle
	return winner
