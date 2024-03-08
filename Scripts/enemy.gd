extends CharacterBody2D

enum enemyEnum {Basic, Ghost, Smart, Dumb}
@export var enemyId: enemyEnum

const NORMALSPEED = 200.0
const GHOSTSPEED = 100.0
const SMARTSPEED = 250.0
const DELTAMULTIPLIER = 10.0
var currentSpeed
var previousFrameVelocity = Vector2(0,0)

var rng = RandomNumberGenerator.new()

@onready var Astar = AStarGrid2D.new()
var tilemap

@onready var sprite = %Sprite
@onready var collision = %Collision
@onready var ray_cast_left_right = %RayCastLeftRight
@onready var ray_cast_up_down_right = %RayCastUpDownRight
@onready var ray_cast_up_down_left = %RayCastUpDownLeft
@onready var timer = %Timer

var isPhasing = false

func _ready():
	changeColor()
	setSpeed()
	rng.randomize()
	chooseRandomDirection(0.0)
	createAstar()

func _physics_process(delta):
	handleMovement(delta)
	handleAnimation()
	handlePhasing()
	
	move_and_slide()

func chooseRandomDirection(_delta):
	if timer.is_stopped() and not isPhasing:
		timer.start(rng.randi_range(2,4))
	var random = rng.randi_range(1,99)
	if random >= 1 and random < 25 and previousFrameVelocity.x != 1:
		previousFrameVelocity = Vector2(1, 0)
	elif random >= 25 and random < 50 and previousFrameVelocity.x != -1:
		previousFrameVelocity = Vector2(-1, 0)
	elif random >= 50 and random < 75 and previousFrameVelocity.y != 1:
		previousFrameVelocity = Vector2(0, 1)
	elif random >= 75 and random < 99 and previousFrameVelocity.y != -1:
		previousFrameVelocity = Vector2(0, -1)
	else:
		chooseRandomDirection(_delta)

func createAstar():
	tilemap = get_tree().get_first_node_in_group("TileMap")
	
	var tilemap_size = tilemap.get_used_rect().end - tilemap.get_used_rect().position
	var map_rect = Rect2i(Vector2i.ZERO, tilemap_size)
	var tile_size = tilemap.get_tileset().tile_size
	
	Astar.region = map_rect
	Astar.cell_size = tile_size
	Astar.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	Astar.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	Astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	Astar.update()
	
	makeSolids()

func handleMovement(delta):
	ray_cast_left_right.target_position.x = previousFrameVelocity.x * 7
	ray_cast_up_down_left.target_position.y = previousFrameVelocity.y * 3
	ray_cast_up_down_right.target_position.y = previousFrameVelocity.y * 3
	match enemyId:
		enemyEnum.Basic:
			basicMovment(delta)
		enemyEnum.Ghost:
			ghostMovment(delta)
		enemyEnum.Smart:
			smartMovment(delta)
		enemyEnum.Dumb:
			dumbMovment(delta)

func basicMovment(delta):
	doMovement(chooseRandomDirection, delta)

#TODO
func ghostMovment(delta):
	doMovement(phase, delta)
	#Make phase and handle movement

#TODO
func smartMovment(delta):
	doMovement(findClosestPath, delta)

#TODO
func dumbMovment(delta):
	doMovement(findClosestPath, delta)
	#change to findLongestPath

func doMovement(function: Callable, delta):
	var random = rng.randi_range(1,99)
	if previousFrameVelocity.x != 0 and not ray_cast_left_right.is_colliding():
		move(Vector2(previousFrameVelocity.x,0), delta)
	elif previousFrameVelocity.x != 0 and ray_cast_left_right.is_colliding():
		if random < 25:
			function.bind(delta).call()
		else:
			chooseRandomDirection(delta)
	if previousFrameVelocity.y != 0 and not ray_cast_up_down_left.is_colliding() and not ray_cast_up_down_right.is_colliding():
		move(Vector2(0, previousFrameVelocity.y), delta)
	elif previousFrameVelocity.y != 0 and (ray_cast_up_down_left.is_colliding() or ray_cast_up_down_right.is_colliding()):
		if random < 25:
			function.bind(delta).call()
		else:
			chooseRandomDirection(delta)

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

func findClosestPath(delta):
	var player = findClosestPlayer()
	if player == null:
		chooseRandomDirection(delta)
		return
	
	Astar.update()
	makeSolids()
	
	var current_path = Astar.get_id_path(
		tilemap.local_to_map(global_position),
		tilemap.local_to_map(player.global_position)
	)
	if current_path.is_empty():
		chooseRandomDirection(delta)
		return
	
	var target_pos = tilemap.map_to_local(current_path.front())
	var targetVector = target_pos - global_position
	
	if targetVector.x > 0:
		move(Vector2(1,0), delta)
	elif targetVector.x < 0:
		move(Vector2(-1,0), delta)
	if targetVector.y > 0:
		move(Vector2(0,1), delta)
	elif targetVector.y < 0:
		move(Vector2(0,-1), delta)

#TODO
func phase(_delta):
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

func _on_timer_timeout():
	chooseRandomDirection(0.0)

func findClosestPlayer():
	var closest
	var players = get_tree().get_nodes_in_group("Player")
	for player in players:
		if closest == null:
			closest = player
		else:
			if global_position.distance_to(closest.global_position) < global_position.distance_to(player.global_position):
				closest = player
	return closest

func makeSolids():
	makeWallsSolid()
	makeBoxesSolid()
	makeBombsSolid()

func makeWallsSolid():
	var tilemap_size = tilemap.get_used_rect().end - tilemap.get_used_rect().position
	for i in tilemap_size.x:
		for j in tilemap_size.y:
			var coords = Vector2i(i, j)
			var tile_data = tilemap.get_cell_tile_data(0, coords)
			if tile_data and tile_data.get_custom_data('type') == "Wall":
				Astar.set_point_solid(coords, true)

func makeBoxesSolid():
	var boxes = get_tree().get_nodes_in_group("WoodenBox")
	for box in boxes:
		var coords = tilemap.local_to_map(tilemap.to_local(box.global_position))
		Astar.set_point_solid(coords, true)

func makeBombsSolid():
	var bombs = get_tree().get_nodes_in_group("Bomb")
	for bomb in bombs:
		var coords = tilemap.local_to_map(tilemap.to_local(bomb.global_position))
		Astar.set_point_solid(coords, true)
