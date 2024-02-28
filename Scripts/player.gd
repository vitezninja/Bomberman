extends CharacterBody2D
@export var playerId: int = 0

const NORMALSPEED = 300.0
const POWERUPSPEED = 100.0
const DEBUFFSPEED = -100.0

var currentSpeed = NORMALSPEED
var previousFrameVelocity = Vector2(0,0)

const MAXBOMBTIMER = 1.0
var bombTimer = MAXBOMBTIMER

const DELTAMULTIPLIER = 10.0

@onready var sprite = %Sprite
@onready var bomb = preload("res://Scenes/Bomb.tscn")

var up = "up_player_"
var down = "down_player_"
var left = "left_player_"
var right = "right_player_"
var bombPlace = "bomb_player_"

func _ready():
	handleInputMap()
	changeColor()

func _physics_process(delta):
	handleMovement(delta)
	handleAnimation()
	checkBombAction()
	bombTimer -= delta
	move_and_slide()

func handleInputMap():
	if playerId > 3 or playerId <= 0:
		print("Error playerId is not between 1 and 3 it's " + str(playerId))
		set_physics_process(false)
		queue_free()
	up += str(playerId)
	down += str(playerId)
	left += str(playerId)
	right += str(playerId)
	bombPlace += str(playerId)

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

func checkBombAction():
	if Input.is_action_just_pressed(bombPlace) and bombTimer <= 0:
		place()
		
func place():
	var thisBomb = bomb.instantiate()
	thisBomb.global_position = global_position
	get_tree().get_first_node_in_group("Bombs").add_child(thisBomb)
	bombTimer = MAXBOMBTIMER

func hit():
	set_physics_process(false)
	sprite.play("Death")
	await sprite.animation_finished
	queue_free()

func changeColor():
	match playerId:
		1:
			sprite.modulate = Color(1,0,0)
		2:
			sprite.modulate = Color(0,1,0)
		3:
			sprite.modulate = Color(0,0,1)
