extends StaticBody2D

@onready var sprite = %Sprite
@onready var collision = %Collision
@onready var area = %Hitbox

func _ready():
	collision.disabled = true
	for i in range(3):
		await get_tree().create_timer(1).timeout
		timeOut()
	var areas = area.get_overlapping_areas()
	for thisArea in areas:
		var parent = thisArea.get_parent()
		if parent.is_in_group("Player"):
			parent.hit()
		if parent.is_in_group("Enemy"):
			parent.hit()
	queue_free()

func _on_area_2d_body_exited(body):
	call_deferred("enableCollision")

func enableCollision():
	collision.disabled = false

func timeOut():
	sprite.modulate = Color(1,0,0,1)
	#sprite.material.set_shader_parameter("my_switch", true)
	await get_tree().create_timer(0.2).timeout
	#sprite.material.set_shader_parameter("my_switch", false)
	sprite.modulate = Color(1,1,1,1)
