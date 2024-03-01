extends StaticBody2D

@onready var sprite = %Sprite
@onready var collision = %Collision
@onready var area = %Hitbox
var playerId
var maxRange
var automaticDetonation

func _ready():
	collision.disabled = true
	if automaticDetonation:
		startExploding()

func _on_area_2d_body_exited(_body):
	call_deferred("enableCollision")

func _on_hitbox_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if area.get_parent().is_in_group("bombEffect"):
		chainExplod()

func enableCollision():
	collision.disabled = false

func timeOut():
	sprite.modulate = Color(1,0,0,1)
	await get_tree().create_timer(0.2).timeout
	sprite.modulate = Color(1,1,1,1)

func startExploding():
	for i in range(3):
		await get_tree().create_timer(1).timeout
		timeOut()
	explode()

func explode():
	var areas = area.get_overlapping_areas()
	for thisArea in areas:
		var parent = thisArea.get_parent()
		if parent.is_in_group("Player"):
			parent.hit()
		if parent.is_in_group("Enemy"):
			parent.hit()
	var players = get_tree().get_nodes_in_group("Player")
	for player in players:
		if player.playerId == playerId:
			player.bombs.erase(self)
			break
	createEffect()
	queue_free()

#TODO
func chainExplod():
	pass

#TODO
func createEffect():
	pass
