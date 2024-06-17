extends Node

const SERVER: PackedScene = preload("res://Scenes/Network/Server.tscn")
const CLIENT: PackedScene = preload("res://Scenes/Network/Client.tscn")
const online_menu: PackedScene = preload("res://Scenes/Menus/OnlineMenu.tscn")


func _ready() -> void:
	handleArgs()


func handleArgs() -> void:
	for argument: String in OS.get_cmdline_args():
		if argument.begins_with("--server"):
			var parts: PackedStringArray = argument.split(":")
			if parts.size() == 2:
				addServer(int(parts[1]))
			elif parts.size() == 1:
				addServer()
			else:
				printerr("Server argument is given in the wrong format. Right format: [--server:{Portnumber}] or [--server] to use port 8000")
				get_tree().quit()
			break


func addServer(port: int = 8000) -> void:
	var server: Node = SERVER.instantiate()
	server.setPort(port)
	
	var root: Node2D = get_tree().get_first_node_in_group("Root")
	if root == null:
		printerr("Server didn't have root node")
		get_tree().quit()
	root.add_child(server)
	
	var world_selector: WorldSelector = get_tree().get_first_node_in_group("WorldSelector")
	if world_selector == null:
		printerr("Server didn't have worldSelector node")
		get_tree().quit()
	world_selector.gameType = WorldSelector.gameTypeEnum.Online
	world_selector.loadLobby()
	
	for menu: Control in get_tree().get_first_node_in_group("Menu").get_children():
		menu.queue_free()
	
	var online: Control = online_menu.instantiate()
	var menu: CanvasLayer = get_tree().get_first_node_in_group("Menu")
	if menu == null:
		printerr("Server didn't have menu node")
		get_tree().quit()
	menu.add_child(online)


func addClient() -> void:
	var client: Node = CLIENT.instantiate()
	
	var root: Node2D = get_tree().get_first_node_in_group("Root")
	if root == null:
		printerr("Client didn't have root node")
		get_tree().quit()
	root.add_child(client)
	
	client.creatPeer()


@rpc("authority", "call_remote", "reliable")
func sendMapNumber(mapNum: int) -> void:
	var world_selector: WorldSelector = get_tree().get_first_node_in_group("WorldSelector")
	if world_selector == null:
		printerr("Peer didn't have worldSelector node")
		get_tree().quit()
	world_selector.currentMap = mapNum as WorldSelector.mapIdEnum


@rpc("authority", "call_local", "reliable")
func startGame() -> void:
	var world_selector: WorldSelector = get_tree().get_first_node_in_group("WorldSelector")
	if world_selector == null:
		printerr("Peer didn't have worldSelector node")
		get_tree().quit()
	world_selector.readied = false
	world_selector.gameStatus = WorldSelector.gameStatusEnum.Running
	
	var this_online_menu: Control = get_tree().get_first_node_in_group("OnlineMenu")
	if not this_online_menu == null:
		GameStats.newSet()
		this_online_menu.deleteMenu()
		return
	
	var online_gameover_menu: Control = get_tree().get_first_node_in_group("OnlineGameOver")
	if not online_gameover_menu == null:
		online_gameover_menu.deleteMenu()
		return
	
	# Peer didn't have neither OnlineMenu or OnlineGameOverMenu. This shouldn't happen
	printerr("Peer didn't have worldSelector node")
	get_tree().quit()


@rpc("any_peer", "call_remote", "reliable")
func sendPlayerReadied() -> void:
	if not multiplayer.is_server():
		return
	
	var world_selector: WorldSelector = get_tree().get_first_node_in_group("WorldSelector")
	if world_selector == null:
		printerr("Server didn't have worldSelector node")
		get_tree().quit()
		
	var server: Node = get_tree().get_first_node_in_group("Server")
	if server == null:
		printerr("Server didn't have Server node")
		get_tree().quit()
	
	var sender: int = multiplayer.get_remote_sender_id()
	if server.readiedPeers.has(sender):
		printerr("This player already readied")
		get_tree().quit()
	else:
		server.readiedPeers[sender] = 1
		world_selector.readyCount += 1


@rpc("any_peer", "call_remote", "reliable")
func sendInput(input: String) -> void:
	if not multiplayer.is_server():
		return
	
	var players: Array = get_tree().get_nodes_in_group("Player")
	var server: Node = get_tree().get_first_node_in_group("Server")
	if server == null:
		printerr("Server didn't have server node")
		get_tree().quit()
		
	var playerId: int = server.peers[multiplayer.get_remote_sender_id()]
	
	for player: OnlinePlayer in players:
		if player.playerId == playerId:
			if input == "bomb":
				player.handleBombAction()
			elif input == "box":
				player.handleBoxAction()
			else:
				player.inputDir = input


@rpc("authority", "call_remote", "reliable")
func serverShutDown() -> void:
	print("Shut Down: ", multiplayer.get_unique_id())
	get_tree().quit()


@rpc("authority", "call_remote", "reliable")
func endGame() -> void:
	var world_selector: WorldSelector = get_tree().get_first_node_in_group("WorldSelector")
	if world_selector == null:
		printerr("Client didn't have worldSelector node")
		get_tree().quit()
	world_selector.gameStatus = WorldSelector.gameStatusEnum.Idle
