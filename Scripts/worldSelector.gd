extends Node2D

enum gameTypeEnum {Offline, Online}

@export var currentMap: PackedScene
var playerCount: int
@export var gameType: gameTypeEnum

func statOfflineGame():
	var map = currentMap.instantiate()
	map.playerCount = playerCount
	add_child(map)

#TODO
func startOnlineGame():
	pass

#TODO
func endOfflineGame():
	pass

#TODO
func endOnlineGame():
	pass
