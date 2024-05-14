extends Node

const SERVER: PackedScene = preload("res://Scenes/Network/Server.tscn")
const CLIENT: PackedScene = preload("res://Scenes/Network/Client.tscn")

func _ready() -> void:
	handleArgs()


func handleArgs() -> void:
	for argument: String in OS.get_cmdline_args():
		if argument.begins_with("--serverPort="):
			var parts: PackedStringArray = argument.split("=")
			addServer(int(parts[1]))
			break


func addServer(port: int) -> void:
	var server: Node = SERVER.instantiate()
	get_tree().get_first_node_in_group("Root").add_child(server)
	server.setPort(port)
	var world_selector: WorldSelector = get_tree().get_first_node_in_group("WorldSelector")
	if world_selector == null:
		return
	world_selector.gameType = WorldSelector.gameTypeEnum.Online
	world_selector.loadLobby()
	for menu: Control in get_tree().get_first_node_in_group("Menu").get_children():
		menu.queue_free()


func addClient() -> void:
	var client: Node = CLIENT.instantiate()
	get_tree().get_first_node_in_group("Root").add_child(client)
	client.creatPeer()


@rpc("any_peer", "call_local", "reliable")
func disconnectClient(readied: bool) -> void:
	if not multiplayer.is_server():
		return
	multiplayer.disconnect_peer(multiplayer.get_remote_sender_id())
	var world_selector: WorldSelector = get_tree().get_first_node_in_group("WorldSelector")
	if world_selector == null:
		return
	if readied:
		world_selector.readyCount -= 1
	
	
@rpc("authority", "call_remote", "reliable", 2)
func sendPlayerCount(number: int) -> void:
	if not multiplayer.is_server():
		return
	var world_selector: WorldSelector = get_tree().get_first_node_in_group("WorldSelector")
	if world_selector == null:
		return
	world_selector.readyCount = number
	
@rpc("authority", "call_remote", "reliable", 2)
func sendMapNumber(mapNum: int) -> void:
	if not multiplayer.is_server():
		return
	var world_selector: WorldSelector = get_tree().get_first_node_in_group("WorldSelector")
	if world_selector == null:
		return
	world_selector.currentMap = mapNum as WorldSelector.mapIdEnum
	
@rpc("authority", "call_remote", "reliable")
func startGame() -> void:
	if not multiplayer.is_server():
		return
	var online_menu: Control = get_tree().get_first_node_in_group("OnlineMenu")
	if online_menu == null:
		return
	online_menu.deleteMenu()
	
@rpc("any_peer", "call_remote", "reliable")
func sendPlayerJoined() -> void:
	if not multiplayer.is_server():
		return
	var world_selector: WorldSelector = get_tree().get_first_node_in_group("WorldSelector")
	if world_selector == null:
		return
	world_selector.readyCount += 1
	

@rpc("any_peer", "call_remote", "reliable", 2)
func sendInput(input: String) -> void:
	if not multiplayer.is_server():
		return
	var players: Array = get_tree().get_nodes_in_group("Player")
	var server: Node = get_tree().get_first_node_in_group("Server")
	var playerId: int = server.peers[multiplayer.get_remote_sender_id()]
	
	for player: OnlinePlayer in players:
		if player.playerId == playerId:
			if input == "bomb":
				player.handleBombAction()
			elif input == "box":
				player.handleBoxAction()
			else:
				player.inputDir = input
