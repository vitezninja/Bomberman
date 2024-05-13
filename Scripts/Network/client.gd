extends Node

var address: String = "127.0.0.1"
var port: int = 8000
var peer: ENetMultiplayerPeer

func _exit_tree() -> void:
	Network.disconnectClient.rpc_id(1)


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

func _physics_process(delta):
	if not get_tree().get_first_node_in_group("WorldSelector").get_child(0).is_instance_valid():
		return
	if Input.is_action_just_pressed("up_player_1"):
		Network.sendInput.rpc_id(1, "up")
	if Input.is_action_just_pressed("down_player_1"):
		Network.sendInput.rpc_id(1, "donw")
	if Input.is_action_just_pressed("right_player_1"):
		Network.sendInput.rpc_id(1, "right")
	if Input.is_action_just_pressed("left_player_1"):
		Network.sendInput.rpc_id(1, "left")
	if Input.is_action_just_pressed("bomb_player_1"):
		Network.sendInput.rpc_id(1, "bomb")
	if Input.is_action_just_pressed("box_player_1"):
		Network.sendInput.rpc_id(1, "box")
	if not Input.is_anything_pressed():
		Network.sendInput.rpc_id(1, "None")
