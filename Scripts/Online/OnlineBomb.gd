extends StaticBody2D
class_name OnlineBomb

@onready var sprite: Sprite2D = %Sprite
@onready var collision: CollisionShape2D = %Collision
@onready var hitbox: Area2D = %Hitbox
@onready var timer: Timer = %Timer
@onready var effect: PackedScene = preload("res://Scenes/Online/OnlineBombEffect.tscn")
var playerId: OnlinePlayer.playerEnum
var maxRange: int
var automaticDetonation: bool
var ticks: int = 0

func _ready() -> void:
	if not multiplayer.is_server():
		return
	collision.disabled = true
	if automaticDetonation:
		startExploding()

func _on_area_2d_body_exited(_body: Node2D) -> void:
	if not multiplayer.is_server():
		return
	call_deferred("enableCollision")

func _on_hitbox_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if not multiplayer.is_server():
		return
	if area.get_parent().is_in_group("bombEffect"):
		chainExplod()

func enableCollision() -> void:
	if not multiplayer.is_server():
		return
	collision.disabled = false

func timeOut() -> void:
	if not multiplayer.is_server():
		return
	sprite.modulate = Color(1,0,0,1)
	await get_tree().create_timer(0.2).timeout
	sprite.modulate = Color(1,1,1,1)

func startExploding() -> void:
	if not multiplayer.is_server():
		return
	timer.start(1)

func explode() -> void:
	if not multiplayer.is_server():
		return
	await get_tree().create_timer(0.2).timeout
	var areas: Array[Area2D] = hitbox.get_overlapping_areas()
	for thisArea in areas:
		var parent: Node = thisArea.get_parent()
		if parent.is_in_group("Player"):
			parent.hit()
		if parent.is_in_group("Enemy"):
			parent.hit()
	var players: Array[Node] = get_tree().get_nodes_in_group("Player")
	for player in players:
		if player.playerId == playerId:
			player.bombs.erase(self)
			match playerId:
				0:
					GameStats.addBomb(0)
				1:
					GameStats.addBomb(1)
				2:
					GameStats.addBomb(2)
			break
	createEffect()
	queue_free()

func chainExplod() -> void:
	if not multiplayer.is_server():
		return
	timer.stop()
	explode()

func createEffect() -> void:
	if not multiplayer.is_server():
		return
	var thisEffect: OnlineBombEffect = effect.instantiate()
	thisEffect.global_position = global_position
	thisEffect.maxRange = maxRange
	get_tree().get_first_node_in_group("BombEffects").add_child(thisEffect, true)

func _on_timer_timeout() -> void:
	if not multiplayer.is_server():
		return
	ticks += 1
	timeOut()
	if ticks == 3:
		timer.stop()
		explode()
