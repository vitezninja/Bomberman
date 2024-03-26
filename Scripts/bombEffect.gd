extends Node2D
class_name BombEffect

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

const oneByOnePNG: Resource = preload("res://Assets/Effects/1x1.png")
const middlePNG: Resource = preload("res://Assets/Effects/middle.png")

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

func _ready() -> void:
	timer.start()

func expand() -> void:
	if not raycast_top.is_colliding() and collisionTop.shape.size.y < (maxRange * 16) and not stopTop:
		expandTop()
	elif raycast_top.is_colliding() and not collisionTop.shape.size.y == (maxRange * 16):
		expodeIfBox(raycast_top.get_collider(), "stopTop")
		
	if not raycast_right.is_colliding() and collisionRight.shape.size.x < (maxRange * 16) and not stopRight:
		expandRight()
	elif raycast_right.is_colliding() and not collisionRight.shape.size.x == (maxRange * 16):
		expodeIfBox(raycast_right.get_collider(), "stopRight")
		
	if not raycast_bottom.is_colliding() and collisionBottom.shape.size.y < (maxRange * 16) and not stopBottom:
		expandbottom()
	elif raycast_bottom.is_colliding() and not collisionBottom.shape.size.y == (maxRange * 16):
		expodeIfBox(raycast_bottom.get_collider(), "stopBottom")
		
	if not raycast_left.is_colliding() and collisionLeft.shape.size.x < (maxRange * 16) and not stopLeft:
		expandLeft()
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
	var centerPNG: Resource = load("res://Assets/Effects/" + centerEx + ".png")
	if centerPNG == null:
		centerPNG = load("res://Assets/Effects/center.png")
	center.texture = centerPNG

func checkEnd() -> void:
	if ticks == maxRange:
		timer.stop()
		queue_free()
	ticks += 1

func _on_timer_timeout() -> void:
	checkEnd()
	expand()

func expandTop() -> void:
	addMiddle(0)
	edge_top.visible = true
	edge_top.position.y += -16
	collisionTop.shape.size.y += 16
	collisionTop.position.y += -8
	raycast_top.position.y += -16 

func expandRight() -> void:
	addMiddle(1)
	edge_right.visible = true
	edge_right.position.x += 16
	collisionRight.shape.size.x += 16
	collisionRight.position.x += 8
	raycast_right.position.x += 16 

func expandbottom() -> void:
	addMiddle(2)
	edge_bottom.visible = true
	edge_bottom.position.y += 16
	collisionBottom.shape.size.y += 16
	collisionBottom.position.y += 8
	raycast_bottom.position.y += 16 

func expandLeft() -> void:
	addMiddle(3)
	edge_left.visible = true
	edge_left.position.x += -16
	collisionLeft.shape.size.x += 16
	collisionLeft.position.x += -8
	raycast_left.position.x += -16 

func addMiddle(index: int) -> void:
	centerExtensions[index] += 1
	if ticks > 1:
		var middle: Sprite2D = Sprite2D.new()
		middle.texture = middlePNG
		match index:
			0:
				middle.position = edge_top.position
				middle.rotation = edge_top.rotation
			1:
				middle.position = edge_right.position
				middle.rotation = edge_right.rotation
			2:
				middle.position = edge_bottom.position
				middle.rotation = edge_bottom.rotation
			3:
				middle.position = edge_left.position
				middle.rotation = edge_left.rotation
		sprites.add_child(middle)

func _on_hitbox_center_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area.get_parent().is_in_group("Player"):
		area.get_parent().hit()
	if area.get_parent().is_in_group("Enemy"):
		area.get_parent().hit()
	if area.get_parent().is_in_group("Bomb"):
		area.get_parent().chainExplod()

func _on_hitbox_top_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area.get_parent().is_in_group("Player"):
		area.get_parent().hit()
	if area.get_parent().is_in_group("Enemy"):
		area.get_parent().hit()
	if area.get_parent().is_in_group("Bomb"):
		area.get_parent().chainExplod()

func _on_hitbox_right_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area.get_parent().is_in_group("Player"):
		area.get_parent().hit()
	if area.get_parent().is_in_group("Enemy"):
		area.get_parent().hit()
	if area.get_parent().is_in_group("Bomb"):
		area.get_parent().chainExplod()

func _on_hitbox_bottom_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area.get_parent().is_in_group("Player"):
		area.get_parent().hit()
	if area.get_parent().is_in_group("Enemy"):
		area.get_parent().hit()
	if area.get_parent().is_in_group("Bomb"):
		area.get_parent().chainExplod()

func _on_hitbox_left_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area.get_parent().is_in_group("Player"):
		area.get_parent().hit()
	if area.get_parent().is_in_group("Enemy"):
		area.get_parent().hit()
	if area.get_parent().is_in_group("Bomb"):
		area.get_parent().chainExplod()

func expodeIfBox(body: Node2D, toChange: String) -> void:
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
