extends Node

var winns: Array[int] = [0,0,0]
var bombs: Array[int] = [0,0,0]
var powerups: Array[int] = [0,0,0]

func addWin(player: Player.playerEnum) -> void:
	match player:
		Player.playerEnum.Player1:
			winns[0] += 1
		Player.playerEnum.Player2:
			winns[1] += 1
		Player.playerEnum.Player3:
			winns[2] += 1

func addBomb(player: Player.playerEnum) -> void:
	match player:
		Player.playerEnum.Player1:
			bombs[0] += 1
		Player.playerEnum.Player2:
			bombs[1] += 1
		Player.playerEnum.Player3:
			bombs[2] += 1

func addPowerUp(player: Player.playerEnum) -> void:
	match player:
		Player.playerEnum.Player1:
			powerups[0] += 1
		Player.playerEnum.Player2:
			powerups[1] += 1
		Player.playerEnum.Player3:
			powerups[2] += 1

func newSet() -> void:
	winns = [0,0,0]
	bombs = [0,0,0]
	powerups = [0,0,0]

func newGame() -> void:
	bombs = [0,0,0]
	powerups = [0,0,0]
