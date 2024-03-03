extends CharacterBody2D

enum enemyEnum {Basic, Ghost, Smart, Dumb}
@export var enemyId: enemyEnum

const NORMALSPEED = 300.0
const GHOSTSPEED = 200.0
const SMARTSPEED = 400.0
const DELTAMULTIPLIER = 10.0
var currentSpeed
var previousFrameVelocity = Vector2(0,0)

@onready var sprite = %Sprite
@onready var collision = %Collision

var isPhasing = false

func _ready():
	changeColor()
	setSpeed()

func _physics_process(delta):
	handleMovement(delta)
	handleAnimation()
	handlePhasing()
	
	move_and_slide()

#TODO
func handleMovement(delta):
	pass

#TODO
func basicMovment(delta):
	pass

#TODO
func ghostMovment(delta):
	pass

#TODO
func smartMovment(delta):
	pass

#TODO
func dumbMovment(delta):
	pass

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

#TODO
func phase():
	pass

#TODO
func handlePhasing():
	pass

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

func hit():
	set_physics_process(false)
	sprite.play("Death")
	await sprite.animation_finished
	queue_free()

func changeColor():
	match enemyId:
		enemyEnum.Basic:
			sprite.modulate = Color(1,1,1)
		enemyEnum.Ghost:
			sprite.modulate = Color(0,0,1)
		enemyEnum.Smart:
			sprite.modulate = Color(0,1,0)
		enemyEnum.Dumb:
			sprite.modulate = Color(1,0,0)

func setSpeed():
	match enemyId:
		enemyEnum.Basic:
			currentSpeed = NORMALSPEED
		enemyEnum.Ghost:
			currentSpeed = GHOSTSPEED
		enemyEnum.Smart:
			currentSpeed = SMARTSPEED
		enemyEnum.Dumb:
			currentSpeed = NORMALSPEED

func _on_hitbox_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if area.get_parent().is_in_group("Player"):
		area.get_parent().hit()
