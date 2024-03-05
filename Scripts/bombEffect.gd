extends Node2D

@onready var collisionTop = %CollisionTop
@onready var collisionRight = %CollisionRight
@onready var collisionBottom = %CollisionBottom
@onready var collisionLeft = %CollisionLeft
#@onready var animationTop = 
#@onready var animationRight = 
#@onready var animationBottom = 
#@onready var animationLeft = 
@onready var timer = %Timer
@onready var raycast_top = %RaycastTop
@onready var raycast_right = %RaycastRight
@onready var raycast_bottom = %RaycastBottom
@onready var raycast_left = %RaycastLeft

var maxRange
var ticks = 0
var stopTop = false
var stopRight = false
var stopBottom = false
var stopLeft = false

func _ready():
	timer.start()

func expand():
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

func checkEnd():
	if ticks == maxRange:
		timer.stop()
		queue_free()
	ticks += 1

func _on_timer_timeout():
	checkEnd()
	expand()

func expandTop():
	collisionTop.shape.size.y += 16
	collisionTop.position.y += -8
	raycast_top.position.y += -16 

func expandRight():
	collisionRight.shape.size.x += 16
	collisionRight.position.x += 8
	raycast_right.position.x += 16 

func expandbottom():
	collisionBottom.shape.size.y += 16
	collisionBottom.position.y += 8
	raycast_bottom.position.y += 16 

func expandLeft():
	collisionLeft.shape.size.x += 16
	collisionLeft.position.x += -8
	raycast_left.position.x += -16 


func _on_hitbox_center_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if area.get_parent().is_in_group("Player"):
		area.get_parent().hit()
	if area.get_parent().is_in_group("Enemy"):
		area.get_parent().hit()
	if area.get_parent().is_in_group("Bomb"):
		area.get_parent().chainExplod()


func _on_hitbox_top_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if area.get_parent().is_in_group("Player"):
		area.get_parent().hit()
	if area.get_parent().is_in_group("Enemy"):
		area.get_parent().hit()
	if area.get_parent().is_in_group("Bomb"):
		area.get_parent().chainExplod()


func _on_hitbox_right_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if area.get_parent().is_in_group("Player"):
		area.get_parent().hit()
	if area.get_parent().is_in_group("Enemy"):
		area.get_parent().hit()
	if area.get_parent().is_in_group("Bomb"):
		area.get_parent().chainExplod()


func _on_hitbox_bottom_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if area.get_parent().is_in_group("Player"):
		area.get_parent().hit()
	if area.get_parent().is_in_group("Enemy"):
		area.get_parent().hit()
	if area.get_parent().is_in_group("Bomb"):
		area.get_parent().chainExplod()


func _on_hitbox_left_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if area.get_parent().is_in_group("Player"):
		area.get_parent().hit()
	if area.get_parent().is_in_group("Enemy"):
		area.get_parent().hit()
	if area.get_parent().is_in_group("Bomb"):
		area.get_parent().chainExplod()

func expodeIfBox(body, toChange):
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
