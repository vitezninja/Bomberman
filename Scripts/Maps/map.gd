extends Node2D

var pauseSwitch = false

func _process(delta):
	handlePause()
	handleGameEnd()

func pauseGame():
	var players = get_tree().get_nodes_in_group("Player")
	var enemys = get_tree().get_nodes_in_group("Enemy")
	var bombs = get_tree().get_nodes_in_group("Bomb")
	var bombEffects = get_tree().get_nodes_in_group("BombEffects")
	for player in players:
		player.set_physics_process(pauseSwitch)
	for enemy in enemys:
		enemy.set_physics_process(pauseSwitch)
	for bomb in bombs:
		bomb.set_physics_process(pauseSwitch)
		if pauseSwitch:
			bomb.timer.start()
		else:
			bomb.timer.stop()
	for bombEffect in bombEffects:
		bombEffect.set_physics_process(pauseSwitch)

func handlePause():
	if Input.is_action_just_pressed("pause"):
		pauseSwitch = !pauseSwitch
		pauseGame()

#TODO
func handleGameEnd():
	pass

#TODO
func endGame():
	queue_free()
