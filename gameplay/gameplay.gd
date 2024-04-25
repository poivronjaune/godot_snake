class_name Gameplay extends Node2D

@onready var head: Head = %Head as Head

var time_between_moves: float = 1000.0
var time_since_last_move: float = 0
var speed: float = 1000.0
var move_dir: Vector2 = Vector2.RIGHT

func _ready() -> void:
	pass
	
	
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_up"):
		move_dir = Vector2.UP 					# (0, -1)
	if Input.is_action_pressed("ui_right"):
		move_dir = Vector2.RIGHT				# (1, 0)
	if Input.is_action_pressed("ui_down"):
		move_dir = Vector2.DOWN					# (0, 1)
	if Input.is_action_pressed("ui_left"):
		move_dir = Vector2.LEFT					# (-1, 0)
		
func _physics_process(delta) -> void:
	time_since_last_move += delta * speed
	if time_since_last_move >= time_between_moves:
		update_snake()
		time_since_last_move = 0

func update_snake():
	print('Move the snake')
	var new_pos: Vector2 = head.position + move_dir * Global.GRID_SIZE
	head.move_to(new_pos)



