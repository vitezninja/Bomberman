extends Node
class_name KeyConfig

static func saveData() -> void:
	var inputMap: Dictionary = {}
	
	for action in getActions():
		inputMap[action] = InputMap.action_get_events(action)
	
	var jsonString: String = JSON.stringify(inputMap)
	
	var file: FileAccess = FileAccess.open("user://KeyConfig.json", FileAccess.WRITE)
	# user/AppData/Roaming/Godot/app_userdata/"ProjectName"/*
	
	if FileAccess.get_open_error() != OK:
		print("File opening error in file KeyConfig.json in function saveDate with error code: ", FileAccess.get_open_error())
		return
	
	file.store_line(jsonString)
	
	file.close()

static func loadData(default: bool = false) -> void:
	var file: FileAccess
	if not FileAccess.file_exists("user://DefaultKeyConfig.json"):
		createDefault()
	file = FileAccess.open("user://DefaultKeyConfig.json", FileAccess.READ)
	if not default and not FileAccess.file_exists("user://KeyConfig.json"):
		saveData()
	elif not default:
		file = FileAccess.open("user://KeyConfig.json", FileAccess.READ)
	# user/AppData/Roaming/Godot/app_userdata/"ProjectName"/*
	
	if FileAccess.get_open_error() != OK:
		print("File opening error in file KeyConfig.json in function loadData with error code: ", FileAccess.get_open_error())
		return
	
	var jsonString: String = file.get_line()
	
	file.close()
	
	var inputMap: Dictionary = JSON.parse_string(jsonString)
	
	deleteActions()
	
	for action in inputMap:
		InputMap.add_action(action)
		for event in inputMap[action]:
			var splitEvent: PackedStringArray = event.split(" ", false)
			match splitEvent[0]:
				"InputEventKey:":
					var new_event: InputEventKey = InputEventKey.new()
					new_event.physical_keycode = int(splitEvent[1])
					InputMap.action_add_event(action, new_event)
				"InputEventJoypadButton:":
					var new_event: InputEventJoypadButton = InputEventJoypadButton.new()
					new_event.button_index = int(splitEvent[1])
					InputMap.action_add_event(action, new_event)
				"InputEventJoypadMotion:":
					var new_event: InputEventJoypadMotion = InputEventJoypadMotion.new()
					new_event.axis = int(splitEvent[1])
					InputMap.action_add_event(action, new_event)

static func restoreToDefault() -> void:
	loadData(true)
	saveData()

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

static func createDefault() -> void:
	if FileAccess.file_exists("user://DefaultKeyConfig.json"):
		return
	
	var inputMap: Dictionary = {}
	
	for action in getActions():
		inputMap[action] = InputMap.action_get_events(action)
	
	var jsonString: String = JSON.stringify(inputMap)
	
	var file: FileAccess = FileAccess.open("user://DefaultKeyConfig.json", FileAccess.WRITE)
	# user/AppData/Roaming/Godot/app_userdata/"ProjectName"/*
	
	if FileAccess.get_open_error() != OK:
		print("File opening error in file DefaultKeyConfig.json in function createDefault with error code: ", FileAccess.get_open_error())
		return
	
	file.store_line(jsonString)
	
	file.close()
