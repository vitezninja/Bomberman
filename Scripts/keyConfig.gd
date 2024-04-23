extends Node
class_name KeyConfig

static func saveData() -> void:
	var inputMap: Dictionary = {}
	
	for action in getActions():
		inputMap[action] = InputMap.action_get_events(action)
		
	var jsonString: String = JSON.stringify(inputMap)
	
	var file = FileAccess.open("user://KeyConfig.json", FileAccess.WRITE)
	# user/AppData/Roaming/Godot/app_userdata/"ProjectName"/*
	if FileAccess.get_open_error() != OK:
		print("File opening error in file keyConfig.gd in function saveDate with error code: ", FileAccess.get_open_error())
		return
	
	file.store_line(jsonString)
	
	file.close()

static func loadData() -> void:
	var file = FileAccess.open("user://KeyConfig.json", FileAccess.READ)
	# user/AppData/Roaming/Godot/app_userdata/"ProjectName"/*
	if FileAccess.get_open_error() != OK:
		print("File opening error in file keyConfig.gd in function saveDate with error code: ", FileAccess.get_open_error())
		return
	
	var jsonString: String = file.get_line()
	
	file.close()
	
	var inputMap: Dictionary = JSON.parse_string(jsonString)
	
	
	for key in inputMap:
		print(key, ":")
		for event in inputMap[key]:
			print("\t", event)

static func printActions() -> void:
	for action in getActions():
		print(action, ": ")
		for event in InputMap.action_get_events(action):
			print("\t",event.as_text())

static func getActions() -> Array[StringName]:
	return InputMap.get_actions()

static func deleteActions() -> void:
	for action in getActions():
		InputMap.erase_action(action)
