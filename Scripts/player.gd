extends CharacterBody2D
class_name Player

enum playerEnum {Player1, Player2, Player3}
@export var playerId: playerEnum

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
var bombs: Array[Bomb]
var hasDetonator: bool = false

const MAXBOXTIMER: float = 1.0
var boxTimer: float = MAXBOXTIMER
var maxBoxCount: int = 3
var boxes: Array[WoodenBox]
var hasBoxes: bool = false

@onready var sprite: AnimatedSprite2D = %Sprite
@onready var bomb: PackedScene = preload("res://Scenes/Bomb.tscn")
@onready var hitbox: Area2D = %Hitbox

var up: String = "up_player_"
var down: String = "down_player_"
var left: String = "left_player_"
var right: String = "right_player_"
var bombPlace: String = "bomb_player_"
var boxPlace: String = "box_player_"

func _ready() -> void:
	handleInputMap()
	changeColor()

func _physics_process(delta: float) -> void:
	if bombTimer >= 0.0:
		bombTimer -= delta
	if boxTimer >= 0.0:
		boxTimer -= delta
	
	handleMovement(delta)
	handleAnimation()
	handleBombAction()
	handleBoxAction()
	handleGhostForm()
	
	move_and_slide()

func handleInputMap() -> void:
	up += str(playerId+1)
	down += str(playerId+1)
	left += str(playerId+1)
	right += str(playerId+1)
	bombPlace += str(playerId+1)
	boxPlace += str(playerId+1)

func handleMovement(delta: float) -> void:
	var x_direction: float = Input.get_axis(left, right)
	var y_direction: float = Input.get_axis(up, down)
	var direction: Vector2
	if x_direction != 0:
		direction = Vector2(x_direction, 0)
	else:
		direction = Vector2(0, y_direction)
	
	move(direction, delta)

func move(input: Vector2, delta: float) -> void:
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
	var isOnBomb = false
	for body in hitbox.get_overlapping_bodies():
		if body.is_in_group("Bomb"):
			isOnBomb = true
			break
	if Input.is_action_just_pressed(bombPlace) and bombTimer <= 0 and bombs.size() < maxBombsCount and not isOnBomb:
		place()
	if Input.is_action_just_pressed(bombPlace) and bombTimer <= 0 and bombs.size() == maxBombsCount and hasDetonator:
		detonate()

func place() -> void:
	var thisBomb: Bomb = bomb.instantiate()
	var tileMap: TileMap = get_tree().get_first_node_in_group("TileMap")
	var bombPos: Vector2 = tileMap.local_to_map(to_local(tileMap.global_position))
	thisBomb.global_position = tileMap.map_to_local(bombPos) * -1
	thisBomb.playerId = playerId
	thisBomb.maxRange = maxBombsRange
	thisBomb.automaticDetonation = !hasDetonator
	get_tree().get_first_node_in_group("Bombs").add_child(thisBomb)
	bombTimer = MAXBOMBTIMER
	bombs.append(thisBomb)

func detonate() -> void:
	for thisBomb in bombs:
		thisBomb.explode()
	bombTimer = MAXBOMBTIMER

func hit() -> void:
	set_physics_process(false)
	sprite.play("Death")
	await sprite.animation_finished
	queue_free()

func changeColor() -> void:
	match playerId:
		playerEnum.Player1:
			sprite.modulate = Color(1,0,0)
		playerEnum.Player2:
			sprite.modulate = Color(0,1,0)
		playerEnum.Player3:
			sprite.modulate = Color(0,0,1)

func increaseBombCount() -> void:
	if maxBombsCount < 4:
		maxBombsCount += 1

func increaseBombRange() -> void:
	if maxBombsRange < 4:
		maxBombsRange += 1

func pickedUpDetonator() -> void:
	hasDetonator = true

func speedBoost() -> void:
	match currentSpeed:
		NORMALSPEED:
			currentSpeed = POWERUPSPEED
		DEBUFFSPEED:
			currentSpeed = NORMALSPEED

func speedDebuff() -> void:
	match currentSpeed:
			NORMALSPEED:
				currentSpeed = DEBUFFSPEED
			POWERUPSPEED:
				currentSpeed = NORMALSPEED

#TODO
func invincibility() -> void:
	pass

#TODO
func ghost() -> void:
	pass

#TODO
func handleGhostForm() -> void:
	pass

func canPlaceBoxes() -> void:
	if hasBoxes and maxBombsCount < 9:
		maxBoxCount += 3
	hasBoxes = true

func handleBoxAction() -> void:
	var isOnBox = false
	for body in hitbox.get_overlapping_bodies():
		if body.is_in_group("WoodenBox"):
			isOnBox = true
			break
	if Input.is_action_just_pressed(boxPlace) and boxTimer <= 0 and boxes.size() < maxBoxCount and hasBoxes and not isOnBox:
		placeBox()

#TODO
func placeBox() -> void:
	pass
