extends CharacterBody2D

@onready var sprite = %Sprite

func _physics_process(_delta):
	move_and_slide()

func hit():
	set_physics_process(false)
	sprite.play("Death")
	await sprite.animation_finished
	queue_free()
