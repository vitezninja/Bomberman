extends Control
class_name HotkeyRebindButton

@onready var action: Label = %Action
@onready var action_key: Button = %ActionKey
@export var action_name: String = "left_player_1"

func _ready() -> void:
	set_process_unhandled_key_input(false)
	set_action_name()
	set_text_for_key()

func set_action_name() -> void:
	action.text = "Unassigned"

	match action_name:
		"left_player_1":
			action.text = "Move left"
		"right_player_1":
			action.text = "Move right"
		"up_player_1":
			action.text = "Move up"
		"down_player_1":
			action.text = "Move down"
		"bomb_player_1":
			action.text = "Place bomb"
		"powerup_player_1":
			action.text = "Use power-up"
		"left_player_2":
			action.text = "Move left"
		"right_player_2":
			action.text = "Move right"
		"up_player_2":
			action.text = "Move up"
		"down_player_2":
			action.text = "Move down"
		"bomb_player_2":
			action.text = "Place bomb"
		"powerup_player_2":
			action.text = "Use power-up"
		"left_player_3":
			action.text = "Move left"
		"right_player_3":
			action.text = "Move right"
		"up_player_3":
			action.text = "Move up"
		"down_player_3":
			action.text = "Move down"
		"bomb_player_3":
			action.text = "Place bomb"
		"powerup_player_3":
			action.text = "Use power-up"
		
		"left_player_1_online":
			action.text = "Move left"
		"right_player_1_online":
			action.text = "Move right"
		"up_player_1_online":
			action.text = "Move up"
		"down_player_1_online":
			action.text = "Move down"
		"bomb_player_1_online":
			action.text = "Place bomb"
		"powerup_player_1_online":
			action.text = "Use power-up"
		"left_player_2_online":
			action.text = "Move left"
		"right_player_2_online":
			action.text = "Move right"
		"up_player_2_online":
			action.text = "Move up"
		"down_player_2_online":
			action.text = "Move down"
		"bomb_player_2_online":
			action.text = "Place bomb"
		"powerup_player_2_online":
			action.text = "Use power-up"
		"left_player_3_online":
			action.text = "Move left"
		"right_player_3_online":
			action.text = "Move right"
		"up_player_3_online":
			action.text = "Move up"
		"down_player_3_online":
			action.text = "Move down"
		"bomb_player_3_online":
			action.text = "Place bomb"
		"powerup_player_3_online":
			action.text = "Use power-up"

func set_text_for_key() -> void:
	var action_events: Array[InputEvent] = InputMap.action_get_events(action_name)
	var action_event: InputEvent = action_events[0]
	var action_keycode: String = OS.get_keycode_string(action_event.physical_keycode)
	
	action_key.text = "%s" % action_keycode

#TODO ezek a ciklusok mit csinálnak?
func _on_action_key_toggled(toggled_on: bool) -> void:
	if toggled_on:
		action_key.text = "Press any key..."
		set_process_unhandled_key_input(toggled_on)
		
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				i.action_key.toggle_mode = false
				i.set_process_unhandled_key_input(false)
	else:
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				i.action_key.toggle_mode = true
				i.set_process_unhandled_key_input(false)
			
		set_text_for_key()

func _unhandled_key_input(event: InputEvent) -> void:
	rebind_action_key(event)
	action_key.button_pressed = false

func rebind_action_key(event: InputEvent) -> void:
	InputMap.action_erase_events(action_name)
	InputMap.action_add_event(action_name, event)
	set_process_unhandled_key_input(false)
	set_text_for_key()
	set_action_name()
