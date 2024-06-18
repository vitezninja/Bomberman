extends Node2D

@onready var light: Light2D = %Light
@onready var shadow: Light2D = %Shadow

@export var Enabled: bool = false
@export_range(0, 20) var radius: float = 1.0
@export_range(0, 10) var light_strenght: float = 1.0


func _physics_process(_delta: float) -> void:
	light.enabled = Enabled
	shadow.enabled = Enabled
	
	light.texture_scale = radius
	shadow.texture_scale = radius
	
	light.energy = light_strenght
	shadow.energy = light_strenght / 2
