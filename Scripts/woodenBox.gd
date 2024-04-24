extends StaticBody2D
class_name WoodenBox

var playerId: Player.playerEnum
var isPlayers: bool = false

@onready var powerup: PackedScene = preload("res://Scenes/PowerUp.tscn")

func destroy():
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	rng.randomize()
	if rng.randi_range(0,1) == 1 and not isPlayers:
		dropPowerUp()
	var players: Array[Node] = get_tree().get_nodes_in_group("Player")
	for player in players:
		if player.playerId == playerId and isPlayers:
			player.boxes.erase(self)
			break
	queue_free()

func dropPowerUp():
	var newPowerup: PowerUp = powerup.instantiate()
	var rng: RandomNumberGenerator = RandomNumberGenerator.new()
	
	rng.randomize()
	newPowerup.type = rng.randi_range(0,6)
	var powerups: Node2D = get_tree().get_first_node_in_group("PowerUps")
	if powerups == null:
		return
	powerups.add_child(newPowerup)
	var tileMap: TileMap = get_tree().get_first_node_in_group("TileMap")
	if tileMap == null:
		return
	var powerupPos: Vector2 = tileMap.local_to_map(to_local(tileMap.global_position))
	newPowerup.global_position = tileMap.map_to_local(powerupPos) * -1
