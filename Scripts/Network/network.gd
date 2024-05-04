extends Node

const SERVER: PackedScene = preload("res://Scenes/Network/Server.tscn")
const CLIENT: PackedScene = preload("res://Scenes/Network/Client.tscn")

func _ready() -> void:
	handleArgs()


func handleArgs() -> void:
	for argument: String in OS.get_cmdline_args():
		if argument.begins_with("--serverPort="):
			var parts: PackedStringArray = argument.split("=")
			var server: Node = SERVER.instantiate()
			get_tree().get_first_node_in_group("Root").add_child(server)
			server.setPort(int(parts[1]))
			break


func addClient() -> void:
	var client: Node = CLIENT.instantiate()
	get_tree().get_first_node_in_group("Root").add_child(client)
