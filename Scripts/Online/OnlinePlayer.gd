extends CharacterBody2D
class_name OnlinePlayer

enum playerEnum {Player1, Player2, Player3}
var playerId: playerEnum

const NORMALSPEED: float = 300.0
const POWERUPSPEED: float = 400.0
const DEBUFFSPEED:float = 200.0
const DELTAMULTIPLIER: float = 10.0
var currentSpeed: float = NORMALSPEED
var previousFrameVelocity: Vector2 = Vector2(0,0)

const MAXBOMBTIMER: float = 1.0
var bombTimer: float = MAXBOMBTIMER
var maxBombsCount: int = 1
var maxBombsRange: int = 2
var bombs: Array[OnlineBomb]
var hasDetonator: bool = false

const MAXBOXTIMER: float = 1.0
var boxTimer: float = MAXBOXTIMER
var maxBoxCount: int = 3
var boxes: Array[OnlineWoodenBox]
var hasBoxes: bool = false

@onready var sprite: AnimatedSprite2D = %Sprite
@onready var bomb: PackedScene = preload("res://Scenes/Online/OnlineBomb.tscn")
@onready var woodenBox: PackedScene = preload("res://Scenes/Online/OnlineWoodenBox.tscn")
@onready var hitbox: Area2D = %Hitbox
@onready var collision_area = %CollisionArea
var up: String = "up_player_"
var down: String = "down_player_"
var left: String = "left_player_"
var right: String = "right_player_"
var bombPlace: String = "bomb_player_"
var boxPlace: String = "box_player_"
var inputDir: String = "None"

func _ready() -> void:
	if not multiplayer.is_server():
		return
	handleInputMap()
	changeColor()

func _physics_process(delta: float) -> void:
	if not multiplayer.is_server():
		return
	if bombTimer >= 0.0:
		bombTimer -= delta
	if boxTimer >= 0.0:
		boxTimer -= delta
	
	handleMovement(delta)
	handleAnimation()
	
	move_and_slide()

func handleInputMap() -> void:
	if not multiplayer.is_server():
		return
	up = "up_player_" + str(playerId+1)
	down = "down_player_" + str(playerId+1)
	left = "left_player_" + str(playerId+1)
	right = "right_player_" + str(playerId+1)
	bombPlace = "bomb_player_" + str(playerId+1)
	boxPlace = "box_player_" + str(playerId+1)

func handleMovement(delta: float) -> void:
	if not multiplayer.is_server():
		return
	var direction: Vector2
	match inputDir:
		"up":
			direction = Vector2(0,-1)
		"down":
			direction = Vector2(0,1)
		"left":
			direction = Vector2(-1,0)
		"right":
			direction = Vector2(1,0)
		"None":
			direction = Vector2(0,0)
	
	move(direction, delta)

func move(input: Vector2, delta: float) -> void:
	if not multiplayer.is_server():
		return
	if input.x != 0:
		velocity.y = move_toward(velocity.y, 0, currentSpeed)
		velocity.x = input.x * currentSpeed * (delta * DELTAMULTIPLIER)
		previousFrameVelocity = input
	elif input.y != 0:
		velocity.x = move_toward(velocity.x, 0, currentSpeed)
		velocity.y = input.y * currentSpeed * (delta * DELTAMULTIPLIER)
		previousFrameVelocity = input
	else:
		velocity.x = move_toward(velocity.x, 0, currentSpeed)
		velocity.y = move_toward(velocity.y, 0, currentSpeed)

func handleAnimation() -> void:
	if not multiplayer.is_server():
		return
	if velocity.x != 0:
		if velocity.x < 0:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
		sprite.play("Walking_Sideways")
	elif velocity.y > 0:
		sprite.play("Walking_Forward")
	elif velocity.y < 0:
		sprite.play("Walking_Backward")
	elif previousFrameVelocity == Vector2(0,0) or previousFrameVelocity == Vector2(0,1):
		sprite.play("Idle_Forward")
	elif previousFrameVelocity == Vector2(0,-1):
		sprite.play("Idle_Backward")
	else:
		sprite.play("Idle_Sideways")

func handleBombAction() -> void:
	if not multiplayer.is_server():
		return
	var isOnBomb: bool = false
	for body in hitbox.get_overlapping_bodies():
		if body.is_in_group("Bomb"):
			isOnBomb = true
			break
	var worldSelector: WorldSelector = get_tree().get_first_node_in_group("WorldSelector")
	if worldSelector == null:
		return
	if bombTimer <= 0 and bombs.size() < maxBombsCount and not isOnBomb and worldSelector.gameStatus != WorldSelector.gameStatusEnum.Locked:
		place()
	
	if bombTimer <= 0 and bombs.size() == maxBombsCount and hasDetonator:
		detonate()

func place() -> void:
	if not multiplayer.is_server():
		return
	var thisBomb: OnlineBomb = bomb.instantiate()
	var tileMap: TileMap = get_tree().get_first_node_in_group("TileMap")
	if tileMap == null:
		return
	var bombPos: Vector2 = tileMap.local_to_map(to_local(tileMap.global_position))
	thisBomb.global_position = tileMap.map_to_local(bombPos) * -1
	thisBomb.playerId = playerId
	thisBomb.maxRange = maxBombsRange
	thisBomb.automaticDetonation = !hasDetonator
	get_tree().get_first_node_in_group("Bombs").add_child(thisBomb, true)
	bombTimer = MAXBOMBTIMER
	bombs.append(thisBomb)

func detonate() -> void:
	if not multiplayer.is_server():
		return
	for thisBomb in bombs:
		thisBomb.explode()
	bombTimer = MAXBOMBTIMER

func hit() -> void:
	if not multiplayer.is_server():
		return
	set_physics_process(false)
	sprite.play("Death")
	if hasDetonator:
		for bomb in bombs:
			bomb.startExploding()
	await sprite.animation_finished
	queue_free()
	

func changeColor() -> void:
	if not multiplayer.is_server():
		return
	match playerId:
		playerEnum.Player1:
			sprite.modulate = Color(1,0,0)
		playerEnum.Player2:
			sprite.modulate = Color(0,1,0)
		playerEnum.Player3:
			sprite.modulate = Color(0,0,1)

func increaseBombCount() -> void:
	if not multiplayer.is_server():
		return
	if maxBombsCount < 4:
		maxBombsCount += 1

func increaseBombRange() -> void:
	if not multiplayer.is_server():
		return
	if maxBombsRange < 4:
		maxBombsRange += 1

func pickedUpDetonator() -> void:
	if not multiplayer.is_server():
		return
	hasDetonator = true

func speedBoost() -> void:
	if not multiplayer.is_server():
		return
	match currentSpeed:
		NORMALSPEED:
			currentSpeed = POWERUPSPEED
		DEBUFFSPEED:
			currentSpeed = NORMALSPEED

func speedDebuff() -> void:
	if not multiplayer.is_server():
		return
	match currentSpeed:
			NORMALSPEED:
				currentSpeed = DEBUFFSPEED
			POWERUPSPEED:
				currentSpeed = NORMALSPEED


func invincibility() -> void:
	if not multiplayer.is_server():
		return
		sprite.modulate = Color(1, 0.9, 0)
		hitbox.monitorable = false
		await get_tree().create_timer(3).timeout
		hitbox.monitorable = true
		changeColor()


func ghost() -> void:
	if not multiplayer.is_server():
		return
		sprite.modulate.a = 0.5
		set_collision_mask_value(1, false)
		set_collision_mask_value(2, false)
		set_collision_mask_value(4, false)
		set_collision_mask_value(5, false)
		z_index = 3
		await get_tree().create_timer(3).timeout
		if collision_area.has_overlapping_bodies():
			hit()
		sprite.modulate.a = 1
		set_collision_mask_value(1, true)
		set_collision_mask_value(2, true)
		set_collision_mask_value(4, true)
		set_collision_mask_value(5, true)
		z_index = 1

func canPlaceBoxes() -> void:
	if not multiplayer.is_server():
		return
	if hasBoxes and maxBoxCount < 9:
		maxBoxCount += 3
	hasBoxes = true

func handleBoxAction() -> void:
	if not multiplayer.is_server():
		return
	var isOnBox = false
	for body in hitbox.get_overlapping_bodies():
		if body.is_in_group("WoodenBox"):
			isOnBox = true
			break
	var worldSelector: WorldSelector = get_tree().get_first_node_in_group("WorldSelector")
	if worldSelector == null:
		return
	if boxTimer <= 0 and boxes.size() < maxBoxCount and hasBoxes and not isOnBox and worldSelector.gameStatus != WorldSelector.gameStatusEnum.Locked:
		placeBox()


func placeBox() -> void:
	if not multiplayer.is_server():
		return
	if not hasBoxes:
		return
	var thisBox: OnlineWoodenBox = woodenBox.instantiate()
	var tileMap: TileMap = get_tree().get_first_node_in_group("TileMap")
	if tileMap == null:
		return
	var boxPos: Vector2 = tileMap.local_to_map(to_local(tileMap.global_position))
	thisBox.global_position = tileMap.map_to_local(boxPos) * -1
	thisBox.playerId = playerId
	thisBox.isPlayers = true
	get_tree().get_first_node_in_group("Boxes").add_child(thisBox, true)
	boxes.append(thisBox)

func setId(id: playerEnum) -> void:
	if not multiplayer.is_server():
		return
	playerId = id
	_ready()
	
