extends GutTest

func before_each() -> void:
	await get_tree().process_frame
	GameStats.newSet()

func test_addWin():
	assert_has_method(GameStats, "addWin", "GameStats must have this method")
	GameStats.addWin(Player.playerEnum.Player1)
	assert_eq(GameStats.winns[0], 1, "This should be 1")
	GameStats.newSet()
	GameStats.addWin(Player.playerEnum.Player2)
	assert_eq(GameStats.winns[1], 1, "This should be 1")
	GameStats.newSet()
	GameStats.addWin(Player.playerEnum.Player3)
	assert_eq(GameStats.winns[2], 1, "This should be 1")

func test_addBomb():
	assert_has_method(GameStats, "addBomb", "GameStats must have this method")
	GameStats.addBomb(Player.playerEnum.Player1)
	assert_eq(GameStats.bombs[0], 1, "This should be 1")
	GameStats.newSet()
	GameStats.addBomb(Player.playerEnum.Player2)
	assert_eq(GameStats.bombs[1], 1, "This should be 1")
	GameStats.newSet()
	GameStats.addBomb(Player.playerEnum.Player3)
	assert_eq(GameStats.bombs[2], 1, "This should be 1")

func test_addPowerUp():
	assert_has_method(GameStats, "addPowerUp", "GameStats must have this method")
	GameStats.addPowerUp(Player.playerEnum.Player1)
	assert_eq(GameStats.powerups[0], 1, "This should be 1")
	GameStats.newSet()
	GameStats.addPowerUp(Player.playerEnum.Player2)
	assert_eq(GameStats.powerups[1], 1, "This should be 1")
	GameStats.newSet()
	GameStats.addPowerUp(Player.playerEnum.Player3)
	assert_eq(GameStats.powerups[2], 1, "This should be 1")

func test_newSet():
	assert_has_method(GameStats, "newSet", "GameStats must have this method")

func test_newGame():
	assert_has_method(GameStats, "newGame", "GameStats must have this method")
