extends CharacterBody2D
class_name OnlineEnemy

enum enemyEnum {
	Basic = 0,
	Ghost = 1,
	Smart = 2,
	Dumb = 3
}

@export var enemyId: enemyEnum

const NORMALSPEED: float = 200.0
const GHOSTSPEED: float = 100.0
const SMARTSPEED: float = 250.0
const DELTAMULTIPLIER: float = 10.0
var currentSpeed: float
var previousFrameVelocity: Vector2 = Vector2(0,0)

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

@onready var Astar: AStarGrid2D = AStarGrid2D.new()
var tilemap: TileMap

@onready var sprite: AnimatedSprite2D = %Sprite
@onready var collision: CollisionShape2D = %Collision
@onready var collision_area: Area2D = %CollisionArea
@onready var ray_cast_left_right: RayCast2D = %RayCastLeftRight
@onready var ray_cast_up_down_right: RayCast2D = %RayCastUpDownRight
@onready var ray_cast_up_down_left: RayCast2D = %RayCastUpDownLeft
@onready var timer: Timer = %Timer

var isPhasing: bool = false
const MINPHASETIME: float = 0.5
var phaseTimer: float

func _ready() -> void :
	if not multiplayer.is_server():
		return
	changeColor()
	setSpeed()
	rng.randomize()
	chooseRandomDirection()
	createAstar()

func _physics_process(delta: float) -> void:
	if not multiplayer.is_server():
		return
	if phaseTimer > 0:
		phaseTimer -= delta
	
	handleMovement(delta)
	handleAnimation()
	handlePhasing()
	
	move_and_slide()

func chooseRandomDirection(_delta: float = 0.0) -> void:
	if not multiplayer.is_server():
		return
	if timer.is_stopped() and not isPhasing:
		timer.start(rng.randi_range(2,4))
	var random: int = rng.randi_range(1,4)
	if random == 1 and previousFrameVelocity.x != 1:
		previousFrameVelocity = Vector2(1, 0)
	elif random == 2 and previousFrameVelocity.x != -1:
		previousFrameVelocity = Vector2(-1, 0)
	elif random == 3 and previousFrameVelocity.y != 1:
		previousFrameVelocity = Vector2(0, 1)
	elif random == 4 and previousFrameVelocity.y != -1:
		previousFrameVelocity = Vector2(0, -1)
	else:
		chooseRandomDirection()

func createAstar() -> void:
	if not multiplayer.is_server():
		return
	tilemap = get_tree().get_first_node_in_group("TileMap")
	
	if tilemap == null:
		return
	
	var tilemap_size: Vector2i = tilemap.get_used_rect().end - tilemap.get_used_rect().position
	var map_rect: Rect2i = Rect2i(Vector2i.ZERO, tilemap_size)
	var tile_size: Vector2i = tilemap.get_tileset().tile_size
	
	Astar.region = map_rect
	Astar.cell_size = tile_size
	Astar.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	Astar.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	Astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	Astar.update()
	
	makeSolids()

func handleMovement(delta: float) -> void:
	if not multiplayer.is_server():
		return
	ray_cast_left_right.target_position.x = previousFrameVelocity.x * 7
	ray_cast_up_down_left.target_position.y = previousFrameVelocity.y * 3
	ray_cast_up_down_right.target_position.y = previousFrameVelocity.y * 3
	match enemyId:
		enemyEnum.Basic:
			doMovement(chooseRandomDirection, delta)
		enemyEnum.Ghost:
			doMovement(phase, delta)
		enemyEnum.Smart:
			doMovement(findClosestPath, delta, true, false)
		enemyEnum.Dumb:
			doMovement(findClosestPath, delta, true, true)

func doMovement(function: Callable, delta: float, path: bool = false, reverse: bool = false) -> void:
	if not multiplayer.is_server():
		return
	var random: int = rng.randi_range(1,4)
	if previousFrameVelocity.x != 0 and not ray_cast_left_right.is_colliding():
		move(Vector2(previousFrameVelocity.x,0), delta)
	elif previousFrameVelocity.x != 0 and ray_cast_left_right.is_colliding():
		if random < 2:
			if path:
				function.bind(delta, reverse).call()
			else:
				function.bind(delta).call()
		else:
			chooseRandomDirection()
	if previousFrameVelocity.y != 0 and not ray_cast_up_down_left.is_colliding() and not ray_cast_up_down_right.is_colliding():
		move(Vector2(0, previousFrameVelocity.y), delta)
	elif previousFrameVelocity.y != 0 and (ray_cast_up_down_left.is_colliding() or ray_cast_up_down_right.is_colliding()):
		if random < 2:
			if path:
				function.bind(delta, reverse).call()
			else:
				function.bind(delta).call()
		else:
			chooseRandomDirection()

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

func findClosestPath(delta: float, reverse: bool) -> void:
	if not multiplayer.is_server():
		return
	var player: OnlinePlayer = findClosestPlayer()
	if player == null:
		chooseRandomDirection()
		return
	
	Astar.update()
	makeSolids()
	
	var current_path: Array[Vector2i] = Astar.get_id_path(
		tilemap.local_to_map(global_position),
		tilemap.local_to_map(player.global_position)
	)
	if current_path.is_empty():
		chooseRandomDirection()
		return
	
	var target_pos: Vector2 = tilemap.map_to_local(current_path.front())
	var targetVector: Vector2 = target_pos - global_position
	if reverse:
		targetVector *= -1
	
	if targetVector.x > 0:
		move(Vector2(1,0), delta)
	elif targetVector.x < 0:
		move(Vector2(-1,0), delta)
	if targetVector.y > 0:
		move(Vector2(0,1), delta)
	elif targetVector.y < 0:
		move(Vector2(0,-1), delta)

func phase(_delta: float) -> void:
	if not multiplayer.is_server():
		return
	if not isPhasing:
		z_index = 3
		phaseTimer = MINPHASETIME
		isPhasing = true
		timer.stop()
		set_collision_mask_value(1, false)
		set_collision_mask_value(5, false)
		ray_cast_left_right.set_collision_mask_value(1, false)
		ray_cast_left_right.set_collision_mask_value(5, false)
		ray_cast_up_down_left.set_collision_mask_value(1, false)
		ray_cast_up_down_left.set_collision_mask_value(5, false)
		ray_cast_up_down_right.set_collision_mask_value(1, false)
		ray_cast_up_down_right.set_collision_mask_value(5, false)

func handlePhasing() -> void:
	if not multiplayer.is_server():
		return
	if isPhasing and not collision_area.has_overlapping_bodies() and phaseTimer <= 0:
		z_index = 1
		isPhasing = false
		timer.start()
		set_collision_mask_value(1, true)
		set_collision_mask_value(5, true)
		ray_cast_left_right.set_collision_mask_value(1, true)
		ray_cast_left_right.set_collision_mask_value(5, true)
		ray_cast_up_down_left.set_collision_mask_value(1, true)
		ray_cast_up_down_left.set_collision_mask_value(5, true)
		ray_cast_up_down_right.set_collision_mask_value(1, true)
		ray_cast_up_down_right.set_collision_mask_value(5, true)

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

func hit() -> void:
	if not multiplayer.is_server():
		return
	set_physics_process(false)
	sprite.play("Death")
	await sprite.animation_finished
	queue_free()

func changeColor() -> void:
	if not multiplayer.is_server():
		return
	match enemyId:
		enemyEnum.Basic:
			sprite.modulate = Color(1,1,1)
		enemyEnum.Ghost:
			sprite.modulate = Color(0,0,1)
		enemyEnum.Smart:
			sprite.modulate = Color(0,1,0)
		enemyEnum.Dumb:
			sprite.modulate = Color(1,0,0)

func setSpeed() -> void:
	if not multiplayer.is_server():
		return
	match enemyId:
		enemyEnum.Basic:
			currentSpeed = NORMALSPEED
		enemyEnum.Ghost:
			currentSpeed = GHOSTSPEED
		enemyEnum.Smart:
			currentSpeed = SMARTSPEED
		enemyEnum.Dumb:
			currentSpeed = NORMALSPEED

func _on_hitbox_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if not multiplayer.is_server():
		return
	if area.get_parent().is_in_group("Player"):
		area.get_parent().hit()

func _on_timer_timeout() -> void:
	if not multiplayer.is_server():
		return
	chooseRandomDirection()

func findClosestPlayer() -> OnlinePlayer:
	if not multiplayer.is_server():
		return
	var closest: OnlinePlayer
	var players: Array[Node] = get_tree().get_nodes_in_group("Player")
	for player in players:
		if closest == null:
			closest = player
		else:
			if global_position.distance_to(closest.global_position) < global_position.distance_to(player.global_position):
				closest = player
	return closest

func makeSolids() -> void:
	if not multiplayer.is_server():
		return
	makeWallsSolid()
	makeObjectsSolid("WoodenBox")
	makeObjectsSolid("Bomb")

func makeWallsSolid() -> void:
	if not multiplayer.is_server():
		return
	var tilemap_size: Vector2 = tilemap.get_used_rect().end - tilemap.get_used_rect().position
	for i in tilemap_size.x:
		for j in tilemap_size.y:
			var coords: Vector2 = Vector2(i, j)
			var tile_data: TileData = tilemap.get_cell_tile_data(0, coords)
			if tile_data and tile_data.get_custom_data('type') == "Wall":
				Astar.set_point_solid(coords, true)

func makeObjectsSolid(objectGroup: String) -> void:
	if not multiplayer.is_server():
		return
	var objects: Array[Node] = get_tree().get_nodes_in_group(objectGroup)
	for object in objects:
		var coords: Vector2i = tilemap.local_to_map(tilemap.to_local(object.global_position))
		Astar.set_point_solid(coords, true)