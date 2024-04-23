extends StaticBody2D
class_name Bomb

@onready var sprite: Sprite2D = %Sprite
@onready var collision: CollisionShape2D = %Collision
@onready var hitbox: Area2D = %Hitbox
@onready var timer: Timer = %Timer
@onready var effect: PackedScene = preload("res://Scenes/BombEffect.tscn")
var playerId: Player.playerEnum
var maxRange: int
var automaticDetonation: bool
var ticks: int = 0

func _ready() -> void:
	collision.disabled = true
	if automaticDetonation:
		startExploding()

func _on_area_2d_body_exited(_body: Node2D) -> void:
	call_deferred("enableCollision")

func _on_hitbox_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area.get_parent().is_in_group("bombEffect"):
		chainExplod()

func enableCollision() -> void:
	collision.disabled = false

func timeOut() -> void:
	sprite.modulate = Color(1,0,0,1)
	await get_tree().create_timer(0.2).timeout
	sprite.modulate = Color(1,1,1,1)

func startExploding() -> void:
	timer.start(1)

func explode() -> void:
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
			GameStats.addBomb(playerId)
			break
	createEffect()
	queue_free()

func chainExplod() -> void:
	timer.stop()
	explode()

func createEffect() -> void:
	var thisEffect: BombEffect = effect.instantiate()
	thisEffect.global_position = global_position
	thisEffect.maxRange = maxRange
	get_tree().get_first_node_in_group("BombEffects").add_child(thisEffect)

func _on_timer_timeout() -> void:
	ticks += 1
	timeOut()
	if ticks == 3:
		timer.stop()
		explode()
