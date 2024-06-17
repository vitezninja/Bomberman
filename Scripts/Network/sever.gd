extends Node

var port: int = 8000
var peer: ENetMultiplayerPeer
var peers: Dictionary = {}
var readiedPeers: Dictionary = {}
var playerIdUsed: Array[int] = []
var playerIdNotUsed: Array[int] =[0,1,2]


func _ready() -> void:
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)
	creatHost()


func _exit_tree() -> void:
	stopHosting()


func peer_connected(id: int) -> void:
	if not multiplayer.is_server():
		printerr("Server is not recognized as a server when a client connects")
		get_tree().quit()
	
	var idNotUsed: int = playerIdNotUsed.pop_front()
	peers[id] = idNotUsed
	playerIdUsed.push_back(idNotUsed)


func peer_disconnected(id: int) -> void:
	if not multiplayer.is_server():
		printerr("Server is not recognized as a server when a client connects")
		get_tree().quit()
	
	var world_selector: WorldSelector = get_tree().get_first_node_in_group("WorldSelector")
	if world_selector == null:
		printerr("Client didn't have worldSelector node")
		get_tree().quit()
	
	var peerId: int = peers[id]
	playerIdUsed.erase(peerId)
	playerIdNotUsed.append(peerId)
	peers.erase(id)
	
	if readiedPeers.has(id):
		world_selector.readyCount -= 1
		readiedPeers.erase(id)


func creatHost() -> void:
	if peer != null:
		printerr("Already a server")
		get_tree().quit()
	
	peer = ENetMultiplayerPeer.new()
	
	var error: Error = peer.create_server(port, 4)
	
	if error != OK:
		printerr("Server can't host: ", error)
		get_tree().quit()
	
	multiplayer.multiplayer_peer = peer


func stopHosting() -> void:
	if not multiplayer.is_server():
		printerr("Server is not recognized as a server when a client connects")
		return
	
	Network.serverShutDown.rpc()
	
	for key: int in peers:
		multiplayer.disconnect_peer(key)


func setPort(value: int) -> void:
	port = value
