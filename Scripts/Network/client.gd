extends Node

var address: String = "127.0.0.1"
var port: int = 8000
var peer: ENetMultiplayerPeer


func _exit_tree() -> void:
	disconectFromServer()


func creatPeer() -> void:
	if peer != null:
		print("Already peer")
		return
	
	peer = ENetMultiplayerPeer.new()
	
	var error: Error = peer.create_client(address, port)
	
	if error != OK:
		printerr("Peer can't join: ", error)
		return
		
	multiplayer.multiplayer_peer = peer


func disconectFromServer() -> void:
	multiplayer.disconnect_peer(multiplayer.get_unique_id())
	peer = null
	port = 8000
	multiplayer.multiplayer_peer = peer
