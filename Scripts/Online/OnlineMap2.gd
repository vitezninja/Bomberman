extends Node2D
@onready var onlineWoodenBox: PackedScene = preload("res://Scenes/Online/OnlineWoodenBox.tscn")
@onready var onlineEnemy: PackedScene = preload("res://Scenes/Online/OnlineEnemy.tscn")
@onready var onlinePlayer: PackedScene = preload("res://Scenes/Online/OnlinePlayer.tscn")
const boxesarr: Array[Vector2] = [
	Vector2(328,136), # 1
	Vector2(40,88), # 6
	Vector2(72,200), # 8
	Vector2(136,184), # 9
	Vector2(312,184), # 7
	Vector2(296,248), # 2
	Vector2(376,200), # 4
	Vector2(392,200), # 5
	Vector2(392,72), # 3
	Vector2(312,88), # 10
	Vector2(248,40), # 11
	Vector2(88,136), # 12
	Vector2(104,230), # 13
	Vector2(200,264), # 16
	Vector2(248,136), # 18
	Vector2(280,104), # 19
	Vector2(120,88), # 20
	Vector2(136,56), # 23
	Vector2(120,56), # 24
	Vector2(136,104), # 25
	Vector2(200,168), # 22
	Vector2(376,136), # 21
	Vector2(376,152), # 17
	Vector2(200,104), # 14
]

const playersarr: Array[Vector2] = [
	Vector2(24,29), # 1
	Vector2(23,261), # 2
	Vector2(455,28), # 3
	Vector2(453,261), # 4
]

const enemisarr: Array[Vector2] = [
	Vector2(296,62), # 5
	Vector2(263,249), # 4
	Vector2(136,141), # 2
	Vector2(344,141), # 1
	Vector2(238,206), # 3
]
const enemiidsarr: Array[int] = [
	2, 
	0, 
	1, 
	0, 
	3, 
]
func spawnBoxes() -> void:
	var boxes:Node2D = get_tree().get_first_node_in_group("Boxes")
	for box in boxesarr:
		var thisBox:OnlineWoodenBox = onlineWoodenBox.instantiate()
		thisBox.position = box
		boxes.add_child(thisBox, true)
func spawnPlayers() -> void:
	var players:Node2D = get_tree().get_first_node_in_group("Players")
	for player in playersarr:
		var thisPlayer:OnlinePlayer = onlinePlayer.instantiate()
		thisPlayer.position = player
		players.add_child(thisPlayer, true)

func spawnEnemies() -> void:
	var enemies:Node2D = get_tree().get_first_node_in_group("Enemys")
	var id:int = 0
	for enemy in enemisarr:
		var thisEnemy:OnlineEnemy = onlineEnemy.instantiate()
		thisEnemy.position = enemy
		thisEnemy.enemyId = enemiidsarr[id]
		id +=1
		enemies.add_child(thisEnemy, true)

func _ready() -> void:
	if not multiplayer.is_server():
		return
	spawnEnemies()
	spawnPlayers()
	spawnBoxes()
