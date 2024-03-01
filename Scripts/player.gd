extends CharacterBody2D

enum playerEnum {Player1, Player2, Player3}
@export var playerId: playerEnum

const NORMALSPEED = 300.0
const POWERUPSPEED = 100.0
const DEBUFFSPEED = -100.0
const DELTAMULTIPLIER = 10.0
var currentSpeed = NORMALSPEED
var previousFrameVelocity = Vector2(0,0)

const MAXBOMBTIMER = 1.0
var bombTimer = MAXBOMBTIMER
var maxBombsCount = 1
var maxBombsRange = 2
var bombs: Array
var hasDetonator = false

const MAXBOXTIMER = 1.0
var boxTimer = MAXBOXTIMER
var maxBoxCount = 3
var boxes: Array
var hasBoxes = false

@onready var sprite = %Sprite
@onready var bomb = preload("res://Scenes/Bomb.tscn")

var up = "up_player_"
var down = "down_player_"
var left = "left_player_"
var right = "right_player_"
var bombPlace = "bomb_player_"
var boxPlace = "box_player_"

func _ready():
	handleInputMap()
	changeColor()

func _physics_process(delta):
	handleMovement(delta)
	handleAnimation()
	handleBombAction()
	handleBoxAction()
	bombTimer -= delta
	boxTimer -= delta
	move_and_slide()

func handleInputMap():
	up += str(playerId+1)
	down += str(playerId+1)
	left += str(playerId+1)
	right += str(playerId+1)
	bombPlace += str(playerId+1)

func handleMovement(delta):
	var x_direction = Input.get_axis(left, right)
	var y_direction = Input.get_axis(up, down)
	var direction
	if x_direction != 0:
		direction = Vector2(x_direction, 0)
	else:
		direction = Vector2(0, y_direction)
	
	move(direction, delta)

func move(input: Vector2, delta):
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

func handleAnimation():
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

func handleBombAction():
	if Input.is_action_just_pressed(bombPlace) and bombTimer <= 0 and bombs.size() < maxBombsCount:
		place()
	#TODO
	#Make detonator work

func place():
	var thisBomb = bomb.instantiate()
	var tileMap = get_tree().get_first_node_in_group("TileMap")
	var bombPos = tileMap.local_to_map(to_local(tileMap.global_position))
	thisBomb.global_position = tileMap.map_to_local(bombPos) * -1
	thisBomb.playerId = playerId
	thisBomb.maxRange = maxBombsRange
	thisBomb.automaticDetonation = !hasDetonator
	get_tree().get_first_node_in_group("Bombs").add_child(thisBomb)
	bombTimer = MAXBOMBTIMER
	bombs.append(thisBomb)

func hit():
	set_physics_process(false)
	sprite.play("Death")
	await sprite.animation_finished
	queue_free()

func changeColor():
	match playerId:
		playerEnum.Player1:
			sprite.modulate = Color(1,0,0)
		playerEnum.Player2:
			sprite.modulate = Color(0,1,0)
		playerEnum.Player3:
			sprite.modulate = Color(0,0,1)

func increaseBombCount():
	maxBombsCount += 1

func increaseBombRange():
	maxBombsRange += 1

func pickedUpDetonator():
	hasDetonator = true

func speedBoost():
	if currentSpeed == NORMALSPEED:
		currentSpeed += POWERUPSPEED

#TODO
func invincibility():
	pass

#TODO
func ghost():
	pass

#TODO
func canPlaceBoxes():
	if hasBoxes:
		maxBoxCount += 3
	hasBoxes = true

#TODO
#Add the input keys
func handleBoxAction():
	pass
	#if Input.is_action_just_pressed(boxPlace) and boxes.size() < maxBoxCount and hasBoxes:
	#	placeBox()

#TODO
func placeBox():
	pass
