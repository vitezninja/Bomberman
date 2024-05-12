extends Node2D

const boxes: Array[Vector2] = [
	Vector2(456,72), # 1
	Vector2(103,120), # 6
	Vector2(136,56), # 8
	Vector2(120,56), # 9
	Vector2(136,104), # 7
	Vector2(200,168), # 2
	Vector2(328,184), # 4
	Vector2(424,200), # 5
	Vector2(200,104), # 3
	Vector2(312,104), # 10
	Vector2(360,72), # 11
	Vector2(408,104), # 12
	Vector2(312,248), # 13
	Vector2(200,248), # 16
	Vector2(152,216), # 18
	Vector2(40,168), # 19
	Vector2(40,135), # 20
	Vector2(40,88), # 23
	Vector2(232,136), # 24
	Vector2(280,152), # 25
	Vector2(104,168), # 22
	Vector2(72,184), # 21
	Vector2(264,248), # 17
	Vector2(424,248), # 14
	Vector2(440,248), # 15
]

const players: Array[Vector2] = [
	Vector2(24,29), # 1
	Vector2(23,265), # 2
	Vector2(458,30), # 3
	Vector2(458,265), # 4
]

const enemis: Array[Vector2] = [
	Vector2(265,63), # 5
	Vector2(282,221), # 4
	Vector2(118,132), # 2
	Vector2(329,77), # 1
	Vector2(105,182), # 3
]

func _ready():
	for box: Vector2 in boxes:
		pass
