extends Node

var port: int = 8000
var peer: ENetMultiplayerPeer
var peers: Dictionary = {}


func _ready() -> void:
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)
	creatHost()


func _exit_tree() -> void:
	stopHosting()


func peer_connected(id: int) -> void:
	if multiplayer.is_server():
		peers[id] = peers.size()


func peer_disconnected(id: int) -> void:
	if multiplayer.is_server():
		multiplayer.disconnect_peer(id)
		peers.erase(id)


func creatHost() -> void:
	if peer != null:
		print("Already hosting")
		return
	
	peer = ENetMultiplayerPeer.new()
	
	var error: Error = peer.create_server(port, 4)
	
	if error != OK:
		printerr("Server can't host: ", error)
		return
	
	multiplayer.multiplayer_peer = peer


func stopHosting() -> void:
	if peer == null or not multiplayer.is_server():
		return
	
	for key in peers:
		multiplayer.disconnect_peer(key)
		
	peers.clear()
	peer = null
	port = 8000
	multiplayer.multiplayer_peer = peer


func setNewConnectionStatus(value: bool) -> void:
	if multiplayer.is_server():
		multiplayer.multiplayer_peer.set_refuse_new_connections(value)


func setPort(value: int) -> void:
	port = value
