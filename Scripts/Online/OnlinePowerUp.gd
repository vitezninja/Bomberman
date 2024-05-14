extends Node2D
class_name OnlinePowerUp

enum powerUpEnum {bombCountIncreas, bombRangeIncreas, detonator, speedIncrease, invincibility, ghost, obstacles}
@export var type: powerUpEnum
@onready var sprite = %Sprite
const BOMB_RANGE_BUFF = preload("res://Assets/Potions/BombRangeBuff.png")
const BOX_BUFF = preload("res://Assets/Potions/BoxBuff.png")
const DETONATOR_BUFF_A = preload("res://Assets/Potions/DetonatorBuffA.png")
const INVINCIBILITY_BUFF = preload("res://Assets/Potions/InvincibilityBuff.png")
const MORE_BOMBS_BUFF = preload("res://Assets/Potions/MoreBombsBuff.png")
const SPEED_BUFF = preload("res://Assets/Potions/SpeedBuff.png")
const GHOST_BUFF = preload("res://Assets/Potions/GhostBuff.png")

func _ready():
	handleSprite()

func _physics_process(_delta: float):
	handleSprite()

func handleSprite():
	match type:
		powerUpEnum.bombCountIncreas:
			sprite.texture = MORE_BOMBS_BUFF
		powerUpEnum.bombRangeIncreas:
			sprite.texture = BOMB_RANGE_BUFF
		powerUpEnum.detonator:
			sprite.texture = DETONATOR_BUFF_A
		powerUpEnum.speedIncrease:
			sprite.texture = SPEED_BUFF
		powerUpEnum.invincibility:
			sprite.texture = INVINCIBILITY_BUFF
		powerUpEnum.ghost:
			sprite.texture = GHOST_BUFF
		powerUpEnum.obstacles:
			sprite.texture = BOX_BUFF


func _on_hitbox_body_entered(body):
	if not multiplayer.is_server():
		return
	match type:
		powerUpEnum.bombCountIncreas:
			body.increaseBombCount()
		powerUpEnum.bombRangeIncreas:
			body.increaseBombRange()
		powerUpEnum.detonator:
			body.pickedUpDetonator()
		powerUpEnum.speedIncrease:
			body.speedBoost()
		powerUpEnum.invincibility:
			body.invincibility()
		powerUpEnum.ghost:
			body.ghost()
		powerUpEnum.obstacles:
			body.canPlaceBoxes()
	GameStats.addPowerUp(body.playerId)
	queue_free()
