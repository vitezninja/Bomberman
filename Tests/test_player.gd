extends GutTest

var player: Player
var delta: float = 0.1
const playerPath: PackedScene = preload("res://Scenes/Player.tscn")

func before_all() -> void:
	player = playerPath.instantiate()
	get_tree().root.add_child(player)

func after_all() -> void:
	player.free()

func test_id() -> void:
	assert_eq(player.playerId, 0, "This should be 0 because we the player still has default Id")

func test_handleInputMap() -> void:
	assert_has_method(player, "handleInputMap", "Player must have this method")
	
	assert_eq(player.up, "up_player_1", "Id is 0 so input map indexes should be 1")
	assert_eq(player.right, "right_player_1", "Id is 0 so input map indexes should be 1")
	assert_eq(player.down, "down_player_1", "Id is 0 so input map indexes should be 1")
	assert_eq(player.left, "left_player_1", "Id is 0 so input map indexes should be 1")
	assert_eq(player.bombPlace, "bomb_player_1", "Id is 0 so input map indexes should be 1")
	assert_eq(player.boxPlace, "box_player_1", "Id is 0 so input map indexes should be 1")

func test_handleMovement() -> void:
	assert_has_method(player, "handleMovement", "Player must have this method")
	player.handleMovement(delta)
	
	assert_eq(player.velocity.x, 0.0, "No input key press so player shouldn't move")
	assert_eq(player.velocity.y, 0.0, "No input key press so player shouldn't move")

func test_move() -> void:
	assert_has_method(player, "move", "Player must have this method")
	
	player.move(Vector2(1,0), delta)
	assert_eq(player.velocity.x, 1 * player.currentSpeed * (player.DELTAMULTIPLIER * delta), "Should move in the +x direction")
	assert_eq(player.velocity.y, 0.0, "Should not move in the y direction")
	
	player.move(Vector2(0,1), delta)
	assert_eq(player.velocity.x, 0.0, "Should not move in the x direction")
	assert_eq(player.velocity.y, 1 * player.currentSpeed * (player.DELTAMULTIPLIER * delta), "Should move in the +y direction")
	
	player.move(Vector2(-1,0), delta)
	assert_eq(player.velocity.x, -1 * player.currentSpeed * (player.DELTAMULTIPLIER * delta), "Should move in the -x direction")
	assert_eq(player.velocity.y, 0.0, "Should not move in the y direction")
	
	player.move(Vector2(0,-1), delta)
	assert_eq(player.velocity.x, 0.0, "Should not move in the x direction")
	assert_eq(player.velocity.y, -1 * player.currentSpeed * (player.DELTAMULTIPLIER * delta), "Should move in the -y direction")
	
	player.velocity = Vector2(0,0)
	player.previousFrameVelocity = Vector2(0,0)
	gut.p("Velocity reset for next test")

func test_handleAnimation() -> void:
	assert_has_method(player, "handleAnimation", "Player must have this method")
	player.handleAnimation()
	assert_eq(player.sprite.animation, "Idle_Forward", "This should be Idle_Forward because the player didn't move yet and this is default value")

func test_handleBombAction() -> void:
	assert_has_method(player, "handleBombAction", "Player must have this method")

func test_place() -> void:
	assert_has_method(player, "place", "Player must have this method")

func test_detonate() -> void:
	assert_has_method(player, "detonate", "Player must have this method")
	player.detonate()
	assert_eq(player.bombTimer, player.MAXBOMBTIMER, "This should cange because we have a delay between bomb placement")

func test_hit() -> void:
	assert_has_method(player, "hit", "Player must have this method")
	player.hit()
	assert_eq(player.sprite.animation, "Death", "This should be Death because the player got hit")

func test_changeColor() -> void:
	assert_has_method(player, "changeColor", "Player must have this method")
	assert_eq(player.sprite.modulate, Color(1,0,0), "This is the default color for id 0")

func test_increaseBombCount() -> void:
	assert_has_method(player, "increaseBombCount", "Player must have this method")
	player.increaseBombCount()
	assert_eq(player.maxBombsCount, 2, "It should increas from 1 to 2")
	player.increaseBombCount()
	player.increaseBombCount()
	player.increaseBombCount()
	assert_eq(player.maxBombsCount, 4, "It should cap out at 4")

func test_increaseBombRange() -> void:
	assert_has_method(player, "increaseBombRange", "Player must have this method")
	player.increaseBombRange()
	assert_eq(player.maxBombsRange, 3, "It should increas from 2 to 3")
	player.increaseBombRange()
	player.increaseBombRange()
	assert_eq(player.maxBombsRange, 4, "It should cap out at 4")

func test_pickedUpDetonator() -> void:
	assert_has_method(player, "pickedUpDetonator", "Player must have this method")
	player.pickedUpDetonator()
	assert_true(player.hasDetonator, "This should be true")

func test_speedBoost() -> void:
	assert_has_method(player, "speedBoost", "Player must have this method")
	player.speedBoost()
	assert_eq(player.currentSpeed, player.POWERUPSPEED, "This should be power up speed")
	player.currentSpeed = player.DEBUFFSPEED
	player.speedBoost()
	assert_eq(player.currentSpeed, player.NORMALSPEED, "This should be normal speed")

func test_speedDebuff() -> void:
	assert_has_method(player, "speedDebuff", "Player must have this method")
	player.speedDebuff()
	assert_eq(player.currentSpeed, player.DEBUFFSPEED, "This should be debuff speed")
	player.currentSpeed = player.POWERUPSPEED
	player.speedDebuff()
	assert_eq(player.currentSpeed, player.NORMALSPEED, "This should be normal speed")

func test_invincibility() -> void:
	assert_has_method(player, "invincibility", "Player must have this method")

func test_ghost() -> void:
	assert_has_method(player, "ghost", "Player must have this method")


func test_canPlaceBoxes() -> void:
	assert_has_method(player, "canPlaceBoxes", "Player must have this method")
	player.canPlaceBoxes()
	assert_true(player.hasBoxes, "This should be true")
	assert_eq(player.maxBoxCount, 3, "This should be 3")
	player.canPlaceBoxes()
	assert_eq(player.maxBoxCount, 6, "This should increas from 3 to 6")
	player.canPlaceBoxes()
	player.canPlaceBoxes()
	player.canPlaceBoxes()
	assert_eq(player.maxBoxCount, 9, "This should cap out at 9")

func test_handleBoxAction() -> void:
	assert_has_method(player, "handleBoxAction", "Player must have this method")

func test_placeBox() -> void:
	assert_has_method(player, "placeBox", "Player must have this method")
