extends Node2D
@onready var onlineWoodenBox: PackedScene = preload("res://Scenes/Online/OnlineWoodenBox.tscn")
@onready var onlineEnemy: PackedScene = preload("res://Scenes/Online/OnlineEnemy.tscn")
@onready var onlinePlayer: PackedScene = preload("res://Scenes/Online/OnlinePlayer.tscn")
 
const boxesarr: Array[Vector2] = [
	Vector2(456,72), # 1
	Vector2(104,136), # 6
	Vector2(120,88), # 8
	Vector2(152,88), # 9
	Vector2(152,120), # 7
	Vector2(184,152), # 2
	Vector2(232,168), # 4
	Vector2(280,152), # 5
	Vector2(312,216), # 3
	Vector2(344,248), # 10
	Vector2(376,216), # 11
	Vector2(440,264), # 12
	Vector2(296,264), # 13
	Vector2(376,152), # 16
	Vector2(408,104), # 18
	Vector2(184,72), # 19
	Vector2(184,24), # 20
	Vector2(312,24), # 23
	Vector2(56,168), # 24
	Vector2(23,120), # 25
	Vector2(56,104), # 22
	Vector2(88,264), # 21
	Vector2(152,248), # 17
	Vector2(248,248), # 14
	Vector2(248,200), # 15
	Vector2(280,104),
	Vector2(344,72),
	Vector2(344,120),
	Vector2(376,40),
	Vector2(24,168),
	Vector2(120,56),
	Vector2(312,136),
	Vector2(200,168),
	Vector2(312,184),
	Vector2(424,200),
	Vector2(200,104),
	Vector2(216,120),
	Vector2(216,184),
]
 
const playersarr: Array[Vector2] = [
	Vector2(24,29), # 1
	Vector2(23,265), # 2
	Vector2(440,40), # 3
	Vector2(440,247), # 4
]
 
const enemisarr: Array[Vector2] = [
	Vector2(249,73), # 5
	Vector2(282,221), # 4
	Vector2(118,132), # 2
	Vector2(329,77), # 1
	Vector2(120,203), # 3
]
func spawnBoxes():
	if not multiplayer.is_server():
		return
	var boxes:Node2D = get_tree().get_first_node_in_group("Boxes")
	for box in boxesarr:
		var thisBox:OnlineWoodenBox = onlineWoodenBox.instantiate()
		thisBox.position = box
		boxes.add_child(thisBox, true)
 
func spawnPlayers():
	if not multiplayer.is_server():
		return
	var players:Node2D = get_tree().get_first_node_in_group("Players")
	for player in playersarr:
		var thisPlayer:OnlinePlayer = onlinePlayer.instantiate()
		thisPlayer.position = player
		players.add_child(thisPlayer, true)
 
func spawnEnemies():
	if not multiplayer.is_server():
		return
	var enemies:Node2D = get_tree().get_first_node_in_group("Enemys")
	for enemy in enemisarr:
		var thisEnemy:OnlineEnemy = onlineEnemy.instantiate()
		thisEnemy.position = enemy
		enemies.add_child(thisEnemy, true)
 
func _ready():
	spawnEnemies()
	spawnPlayers()
	spawnBoxes()
