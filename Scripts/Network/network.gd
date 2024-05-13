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
	get_tree().get_first_node_in_group("WorldSelector").gameType = WorldSelector.gameTypeEnum.Online


func addClient() -> void:
	var client: Node = CLIENT.instantiate()
	get_tree().get_first_node_in_group("Root").add_child(client)
	client.creatPeer()


@rpc("any_peer", "call_local", "reliable")
func disconnectClient() -> void:
	multiplayer.disconnect_peer(multiplayer.get_remote_sender_id())


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
