extends Node

var address: String = "127.0.0.1"
var port: int = 8000
var peer: ENetMultiplayerPeer


func _exit_tree() -> void:
	var world_selector: WorldSelector = get_tree().get_first_node_in_group("WorldSelector")
	if world_selector == null:
		printerr("Client didn't have worldSelector node")
		get_tree().quit()
	world_selector.reset()
	multiplayer.multiplayer_peer = null


func creatPeer() -> void:
	if peer != null:
		printerr("Already a client")
		get_tree().quit()
	
	peer = ENetMultiplayerPeer.new()
	
	var error: Error = peer.create_client(address, port)
	if error != OK:
		printerr("Client can't join: ", error)
		get_tree().quit()
		
	multiplayer.multiplayer_peer = peer


func _physics_process(_delta: float) -> void:
	var world_selector: WorldSelector = get_tree().get_first_node_in_group("WorldSelector")
	if world_selector == null:
		printerr("Client didn't have worldSelector node")
		get_tree().quit()
	if world_selector.gameStatus == WorldSelector.gameStatusEnum.Idle:
		return
	
	if Input.is_action_just_pressed("up_player_1"):
		Network.sendInput.rpc_id(1, "up")
	if Input.is_action_just_pressed("down_player_1"):
		Network.sendInput.rpc_id(1, "down")
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
