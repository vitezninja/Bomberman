extends Node
class_name KeyConfig

const DEFAULT: Dictionary = {"bomb_player_1":["InputEventKey: keycode=4194328 (Alt), mods=none, physical=true, pressed=false, echo=false"],"bomb_player_2":["InputEventKey: keycode=4194326 (Ctrl), mods=none, physical=true, pressed=false, echo=false"],"bomb_player_3":["InputEventKey: keycode=32 (Space), mods=none, physical=true, pressed=false, echo=false"],"box_player_1":["InputEventKey: keycode=88 (X), mods=none, physical=true, pressed=false, echo=false"],"box_player_2":["InputEventKey: keycode=4194325 (Shift), mods=none, physical=true, pressed=false, echo=false"],"box_player_3":["InputEventKey: keycode=77 (M), mods=none, physical=true, pressed=false, echo=false"],"down_player_1":["InputEventKey: keycode=83 (S), mods=none, physical=true, pressed=false, echo=false"],"down_player_2":["InputEventKey: keycode=4194322 (Down), mods=none, physical=true, pressed=false, echo=false"],"down_player_3":["InputEventKey: keycode=75 (K), mods=none, physical=true, pressed=false, echo=false"],"left_player_1":["InputEventKey: keycode=65 (A), mods=none, physical=true, pressed=false, echo=false"],"left_player_2":["InputEventKey: keycode=4194319 (Left), mods=none, physical=true, pressed=false, echo=false"],"left_player_3":["InputEventKey: keycode=74 (J), mods=none, physical=true, pressed=false, echo=false"],"pause":["InputEventKey: keycode=4194305 (Escape), mods=none, physical=true, pressed=false, echo=false"],"right_player_1":["InputEventKey: keycode=68 (D), mods=none, physical=true, pressed=false, echo=false"],"right_player_2":["InputEventKey: keycode=4194321 (Right), mods=none, physical=true, pressed=false, echo=false"],"right_player_3":["InputEventKey: keycode=76 (L), mods=none, physical=true, pressed=false, echo=false"],"ui_accept":["InputEventKey: keycode=32 (Space), mods=none, physical=true, pressed=false, echo=false"],"ui_cancel":["InputEventKey: keycode=4194305 (Escape), mods=none, physical=true, pressed=false, echo=false"],"ui_copy":["InputEventKey: keycode=67 (C), mods=none, physical=true, pressed=false, echo=false","InputEventKey: keycode=4194311 (Insert), mods=none, physical=true, pressed=false, echo=false"],"ui_cut":["InputEventKey: keycode=88 (X), mods=none, physical=true, pressed=false, echo=false","InputEventKey: keycode=4194312 (Delete), mods=none, physical=true, pressed=false, echo=false"],"ui_down":["InputEventKey: keycode=4194322 (Down), mods=none, physical=true, pressed=false, echo=false","InputEventJoypadButton: button_index=12, pressed=false, pressure=0.00","InputEventJoypadMotion: axis=1, axis_value=0.00"],"ui_end":["InputEventKey: keycode=4194318 (End), mods=none, physical=true, pressed=false, echo=false"],"ui_filedialog_refresh":["InputEventKey: keycode=4194336 (F5), mods=none, physical=true, pressed=false, echo=false"],"ui_filedialog_show_hidden":["InputEventKey: keycode=72 (H), mods=none, physical=true, pressed=false, echo=false"],"ui_filedialog_up_one_level":["InputEventKey: keycode=4194308 (Backspace), mods=none, physical=true, pressed=false, echo=false"],"ui_focus_next":["InputEventKey: keycode=4194306 (Tab), mods=none, physical=true, pressed=false, echo=false"],"ui_focus_prev":["InputEventKey: keycode=4194306 (Tab), mods=none, physical=true, pressed=false, echo=false"],"ui_graph_delete":["InputEventKey: keycode=4194312 (Delete), mods=none, physical=true, pressed=false, echo=false"],"ui_graph_duplicate":["InputEventKey: keycode=68 (D), mods=none, physical=true, pressed=false, echo=false"],"ui_home":["InputEventKey: keycode=4194317 (Home), mods=none, physical=true, pressed=false, echo=false"],"ui_left":["InputEventKey: keycode=4194319 (Left), mods=none, physical=true, pressed=false, echo=false","InputEventJoypadButton: button_index=13, pressed=false, pressure=0.00","InputEventJoypadMotion: axis=0, axis_value=0.00"],"ui_menu":["InputEventKey: keycode=4194370 (Menu), mods=none, physical=true, pressed=false, echo=false"],"ui_page_down":["InputEventKey: keycode=4194324 (PageDown), mods=none, physical=true, pressed=false, echo=false"],"ui_page_up":["InputEventKey: keycode=4194323 (PageUp), mods=none, physical=true, pressed=false, echo=false"],"ui_paste":["InputEventKey: keycode=86 (V), mods=none, physical=true, pressed=false, echo=false","InputEventKey: keycode=4194311 (Insert), mods=none, physical=true, pressed=false, echo=false"],"ui_redo":["InputEventKey: keycode=90 (Z), mods=none, physical=true, pressed=false, echo=false","InputEventKey: keycode=89 (Y), mods=none, physical=true, pressed=false, echo=false"],"ui_right":["InputEventKey: keycode=4194321 (Right), mods=none, physical=true, pressed=false, echo=false","InputEventJoypadButton: button_index=14, pressed=false, pressure=0.00","InputEventJoypadMotion: axis=0, axis_value=0.00"],"ui_select":["InputEventJoypadButton: button_index=3, pressed=false, pressure=0.00","InputEventKey: keycode=32 (Space), mods=none, physical=true, pressed=false, echo=false"],"ui_swap_input_direction":["InputEventKey: keycode=96 (QuoteLeft), mods=none, physical=true, pressed=false, echo=false"],"ui_text_add_selection_for_next_occurrence":["InputEventKey: keycode=68 (D), mods=none, physical=true, pressed=false, echo=false"],"ui_text_backspace":["InputEventKey: keycode=4194308 (Backspace), mods=none, physical=true, pressed=false, echo=false"],"ui_text_backspace_all_to_left":[],"ui_text_backspace_all_to_left.macos":["InputEventKey: keycode=4194308 (Backspace), mods=none, physical=true, pressed=false, echo=false"],"ui_text_backspace_word":["InputEventKey: keycode=4194308 (Backspace), mods=none, physical=true, pressed=false, echo=false"],"ui_text_backspace_word.macos":["InputEventKey: keycode=4194308 (Backspace), mods=none, physical=true, pressed=false, echo=false"],"ui_text_caret_add_above":["InputEventKey: keycode=4194320 (Up), mods=none, physical=true, pressed=false, echo=false"],"ui_text_caret_add_above.macos":["InputEventKey: keycode=79 (O), mods=none, physical=true, pressed=false, echo=false"],"ui_text_caret_add_below":["InputEventKey: keycode=4194322 (Down), mods=none, physical=true, pressed=false, echo=false"],"ui_text_caret_add_below.macos":["InputEventKey: keycode=76 (L), mods=none, physical=true, pressed=false, echo=false"],"ui_text_caret_document_end":["InputEventKey: keycode=4194318 (End), mods=none, physical=true, pressed=false, echo=false"],"ui_text_caret_document_end.macos":["InputEventKey: keycode=4194322 (Down), mods=none, physical=true, pressed=false, echo=false"],"ui_text_caret_document_start":["InputEventKey: keycode=4194317 (Home), mods=none, physical=true, pressed=false, echo=false"],"ui_text_caret_document_start.macos":["InputEventKey: keycode=4194320 (Up), mods=none, physical=true, pressed=false, echo=false"],"ui_text_caret_down":["InputEventKey: keycode=4194322 (Down), mods=none, physical=true, pressed=false, echo=false"],"ui_text_caret_left":["InputEventKey: keycode=4194319 (Left), mods=none, physical=true, pressed=false, echo=false"],"ui_text_caret_line_end":["InputEventKey: keycode=4194318 (End), mods=none, physical=true, pressed=false, echo=false"],"ui_text_caret_line_end.macos":["InputEventKey: keycode=69 (E), mods=none, physical=true, pressed=false, echo=false","InputEventKey: keycode=4194321 (Right), mods=none, physical=true, pressed=false, echo=false"],"ui_text_caret_line_start":["InputEventKey: keycode=4194317 (Home), mods=none, physical=true, pressed=false, echo=false"],"ui_text_caret_line_start.macos":["InputEventKey: keycode=65 (A), mods=none, physical=true, pressed=false, echo=false","InputEventKey: keycode=4194319 (Left), mods=none, physical=true, pressed=false, echo=false"],"ui_text_caret_page_down":["InputEventKey: keycode=4194324 (PageDown), mods=none, physical=true, pressed=false, echo=false"],"ui_text_caret_page_up":["InputEventKey: keycode=4194323 (PageUp), mods=none, physical=true, pressed=false, echo=false"],"ui_text_caret_right":["InputEventKey: keycode=4194321 (Right), mods=none, physical=true, pressed=false, echo=false"],"ui_text_caret_up":["InputEventKey: keycode=4194320 (Up), mods=none, physical=true, pressed=false, echo=false"],"ui_text_caret_word_left":["InputEventKey: keycode=4194319 (Left), mods=none, physical=true, pressed=false, echo=false"],"ui_text_caret_word_left.macos":["InputEventKey: keycode=4194319 (Left), mods=none, physical=true, pressed=false, echo=false"],"ui_text_caret_word_right":["InputEventKey: keycode=4194321 (Right), mods=none, physical=true, pressed=false, echo=false"],"ui_text_caret_word_right.macos":["InputEventKey: keycode=4194321 (Right), mods=none, physical=true, pressed=false, echo=false"],"ui_text_clear_carets_and_selection":["InputEventKey: keycode=4194305 (Escape), mods=none, physical=true, pressed=false, echo=false"],"ui_text_completion_accept":["InputEventKey: keycode=4194309 (Enter), mods=none, physical=true, pressed=false, echo=false","InputEventKey: keycode=4194310 (Kp Enter), mods=none, physical=true, pressed=false, echo=false"],"ui_text_completion_query":["InputEventKey: keycode=32 (Space), mods=none, physical=true, pressed=false, echo=false"],"ui_text_completion_replace":["InputEventKey: keycode=4194306 (Tab), mods=none, physical=true, pressed=false, echo=false"],"ui_text_dedent":["InputEventKey: keycode=4194306 (Tab), mods=none, physical=true, pressed=false, echo=false"],"ui_text_delete":["InputEventKey: keycode=4194312 (Delete), mods=none, physical=true, pressed=false, echo=false"],"ui_text_delete_all_to_right":[],"ui_text_delete_all_to_right.macos":["InputEventKey: keycode=4194312 (Delete), mods=none, physical=true, pressed=false, echo=false"],"ui_text_delete_word":["InputEventKey: keycode=4194312 (Delete), mods=none, physical=true, pressed=false, echo=false"],"ui_text_delete_word.macos":["InputEventKey: keycode=4194312 (Delete), mods=none, physical=true, pressed=false, echo=false"],"ui_text_indent":["InputEventKey: keycode=4194306 (Tab), mods=none, physical=true, pressed=false, echo=false"],"ui_text_newline":["InputEventKey: keycode=4194309 (Enter), mods=none, physical=true, pressed=false, echo=false","InputEventKey: keycode=4194310 (Kp Enter), mods=none, physical=true, pressed=false, echo=false"],"ui_text_newline_above":["InputEventKey: keycode=4194309 (Enter), mods=none, physical=true, pressed=false, echo=false","InputEventKey: keycode=4194310 (Kp Enter), mods=none, physical=true, pressed=false, echo=false"],"ui_text_newline_blank":["InputEventKey: keycode=4194309 (Enter), mods=none, physical=true, pressed=false, echo=false","InputEventKey: keycode=4194310 (Kp Enter), mods=none, physical=true, pressed=false, echo=false"],"ui_text_scroll_down":["InputEventKey: keycode=4194322 (Down), mods=none, physical=true, pressed=false, echo=false"],"ui_text_scroll_down.macos":["InputEventKey: keycode=4194322 (Down), mods=none, physical=true, pressed=false, echo=false"],"ui_text_scroll_up":["InputEventKey: keycode=4194320 (Up), mods=none, physical=true, pressed=false, echo=false"],"ui_text_scroll_up.macos":["InputEventKey: keycode=4194320 (Up), mods=none, physical=true, pressed=false, echo=false"],"ui_text_select_all":["InputEventKey: keycode=65 (A), mods=none, physical=true, pressed=false, echo=false"],"ui_text_select_word_under_caret":["InputEventKey: keycode=71 (G), mods=none, physical=true, pressed=false, echo=false"],"ui_text_select_word_under_caret.macos":["InputEventKey: keycode=71 (G), mods=none, physical=true, pressed=false, echo=false"],"ui_text_submit":["InputEventKey: keycode=4194309 (Enter), mods=none, physical=true, pressed=false, echo=false","InputEventKey: keycode=4194310 (Kp Enter), mods=none, physical=true, pressed=false, echo=false"],"ui_text_toggle_insert_mode":["InputEventKey: keycode=4194311 (Insert), mods=none, physical=true, pressed=false, echo=false"],"ui_undo":["InputEventKey: keycode=90 (Z), mods=none, physical=true, pressed=false, echo=false"],"ui_up":["InputEventKey: keycode=4194320 (Up), mods=none, physical=true, pressed=false, echo=false","InputEventJoypadButton: button_index=11, pressed=false, pressure=0.00","InputEventJoypadMotion: axis=1, axis_value=0.00"],"up_player_1":["InputEventKey: keycode=87 (W), mods=none, physical=false, pressed=true, echo=false"],"up_player_2":["InputEventKey: keycode=4194320 (Up), mods=none, physical=true, pressed=false, echo=false"],"up_player_3":["InputEventKey: keycode=73 (I), mods=none, physical=true, pressed=false, echo=false"]}

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

static func loadData(default: bool = false) -> void:
	var file = FileAccess.open("user://KeyConfig.json", FileAccess.READ)
	# user/AppData/Roaming/Godot/app_userdata/"ProjectName"/*
	if FileAccess.get_open_error() != OK:
		print("File opening error in file keyConfig.gd in function saveDate with error code: ", FileAccess.get_open_error())
		return
	
	var jsonString: String = file.get_line()
	
	file.close()
	
	
	var inputMap: Dictionary = JSON.parse_string(jsonString)
	if default:
		inputMap = DEFAULT
	
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

static func resetToDefault() -> void:
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
