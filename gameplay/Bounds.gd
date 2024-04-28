class_name Bounds extends Node2D
@onready var upper_left = $UpperLeft
@onready var lower_right = $LowerRight

var x_max: float
var x_min: float
var y_max: float
var y_min: float

func _ready() -> void:
	x_max = lower_right.position.x
	x_min = upper_left.position.x
	y_max = lower_right.position.y
	y_min = upper_left.position.y

func wrap_vector(v: Vector2) -> Vector2:
	if v.x > x_max:
		return Vector2(x_min, v.y)
	elif v.x < x_min:
		return Vector2(x_max, v.y)
	elif v.y > y_max:
		return Vector2(v.x, y_min)
	elif v.y < y_min:
		return Vector2(v.x, y_max)
		
	return v

	
