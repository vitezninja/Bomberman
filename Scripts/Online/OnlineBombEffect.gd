extends Node2D
class_name OnlineBombEffect

@onready var collisionTop: CollisionShape2D = %CollisionTop
@onready var collisionRight: CollisionShape2D = %CollisionRight
@onready var collisionBottom: CollisionShape2D = %CollisionBottom
@onready var collisionLeft: CollisionShape2D = %CollisionLeft

@onready var sprites: Node2D = %Sprites
@onready var edge_top: Sprite2D = %EdgeTop
@onready var edge_right: Sprite2D = %EdgeRight
@onready var edge_bottom: Sprite2D = %EdgeBottom
@onready var edge_left: Sprite2D = %EdgeLeft
@onready var center: Sprite2D = %Center

var centerExtensions: Array[int] = [0,0,0,0]

const middlePNG: Resource = preload("res://Assets/Effects/middle.png")
const ONLINE_BOMB_EFFECT_MIDDLE: PackedScene = preload("res://Scenes/Online/OnlineBombEffectMiddle.tscn")

@onready var timer: Timer = %Timer
@onready var raycast_top: RayCast2D = %RaycastTop
@onready var raycast_right: RayCast2D = %RaycastRight
@onready var raycast_bottom: RayCast2D = %RaycastBottom
@onready var raycast_left: RayCast2D = %RaycastLeft

var maxRange: int
var ticks: int = 0
var stopTop: bool = false
var stopRight: bool = false
var stopBottom: bool = false
var stopLeft: bool = false
var currentLoad: String = "res://Assets/Effects/center.png"

func _ready() -> void:
	if not multiplayer.is_server():
		return
	timer.start()

func _physics_process(_delta: float):
	chooseCenter()


func expand() -> void:
	if not multiplayer.is_server():
		return
	if not raycast_top.is_colliding() and collisionTop.shape.size.y < (maxRange * 16) and not stopTop:
		addMiddle(0, edge_top)
		expandSide(edge_top, collisionTop, raycast_top, Vector2(0,-1))
	elif raycast_top.is_colliding() and not collisionTop.shape.size.y == (maxRange * 16):
		expodeIfBox(raycast_top.get_collider(), "stopTop")
		
	if not raycast_right.is_colliding() and collisionRight.shape.size.x < (maxRange * 16) and not stopRight:
		addMiddle(1, edge_right)
		expandSide(edge_right, collisionRight, raycast_right, Vector2(1,0))
	elif raycast_right.is_colliding() and not collisionRight.shape.size.x == (maxRange * 16):
		expodeIfBox(raycast_right.get_collider(), "stopRight")
		
	if not raycast_bottom.is_colliding() and collisionBottom.shape.size.y < (maxRange * 16) and not stopBottom:
		addMiddle(2, edge_bottom)
		expandSide(edge_bottom, collisionBottom, raycast_bottom, Vector2(0,1))
	elif raycast_bottom.is_colliding() and not collisionBottom.shape.size.y == (maxRange * 16):
		expodeIfBox(raycast_bottom.get_collider(), "stopBottom")
		
	if not raycast_left.is_colliding() and collisionLeft.shape.size.x < (maxRange * 16) and not stopLeft:
		addMiddle(3, edge_left)
		expandSide(edge_left, collisionLeft, raycast_left, Vector2(-1,0))
	elif raycast_left.is_colliding() and not collisionLeft.shape.size.x == (maxRange * 16):
		expodeIfBox(raycast_left.get_collider(), "stopLeft")
	
	chooseCenter()

func chooseCenter() -> void:
	var centerEx: String = "center" 
	if centerExtensions[0] != 0:
		centerEx += "_top"
	if centerExtensions[1] != 0:
		centerEx += "_right"
	if centerExtensions[2] != 0:
		centerEx += "_bottom"
	if centerExtensions[3] != 0:
		centerEx += "_left"
	var centerPNG: Resource
	if multiplayer.is_server():
		currentLoad = "res://Assets/Effects/" + centerEx + ".png"
	centerPNG = load(currentLoad)
	if centerPNG == null:
		centerPNG = load("res://Assets/Effects/center.png")
	center.texture = centerPNG

func checkEnd() -> void:
	if not multiplayer.is_server():
		return
	if ticks == maxRange:
		timer.stop()
		if not multiplayer.is_server():
			return
		queue_free()
	ticks += 1

func _on_timer_timeout() -> void:
	if not multiplayer.is_server():
		return
	checkEnd()
	expand()

func expandSide(edge: Sprite2D, collision: CollisionShape2D, raycast: RayCast2D, dirVect: Vector2) -> void:
	if not multiplayer.is_server():
		return
	edge.position += dirVect * 16
	collision.shape.size += abs(dirVect * 16)
	collision.position += dirVect * 8
	raycast.position += dirVect * 16

func addMiddle(index: int, edge: Sprite2D) -> void:
	if not multiplayer.is_server():
		return
	centerExtensions[index] += 1
	if ticks > 1:
		var middle: Node2D = ONLINE_BOMB_EFFECT_MIDDLE.instantiate()
		middle.setPosRot(edge.position, edge.rotation)
		sprites.add_child(middle, true)
	edge.visible = true

func _on_hitbox_center_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if not multiplayer.is_server():
		return
	hit(area)

func _on_hitbox_top_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if not multiplayer.is_server():
		return
	hit(area)

func _on_hitbox_right_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if not multiplayer.is_server():
		return
	hit(area)

func _on_hitbox_bottom_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if not multiplayer.is_server():
		return
	hit(area)

func _on_hitbox_left_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if not multiplayer.is_server():
		return
	hit(area)

func hit(area: Area2D) -> void:
	if not multiplayer.is_server():
		return
	if area.get_parent().is_in_group("Player"):
		area.get_parent().hit()
	if area.get_parent().is_in_group("Enemy"):
		area.get_parent().hit()
	if area.get_parent().is_in_group("Bomb"):
		area.get_parent().chainExplod()

func expodeIfBox(body: Node2D, toChange: String) -> void:
	if not multiplayer.is_server():
		return
	if body.is_in_group("WoodenBox"):
		body.destroy()
		match toChange:
			"stopTop":
				stopTop = true
			"stopRight":
				stopRight = true
			"stopBottom":
				stopBottom = true
			"stopLeft":
				stopLeft = true
