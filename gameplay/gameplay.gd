class_name Gameplay extends Node2D

const gameover_scene = preload("res://menus/gameover.tscn")
const pausemenu_scene = preload("res://menus/pausemenu.tscn")


@onready var head: Head = $Head as Head
@onready var bounds: Bounds = $Bounds as Bounds
@onready var spawner: Spawner = $Spawner as Spawner
@onready var hud: HUD = $Hud

var gameover_menu: GameOver
var pause_menu: PauseMenu
var time_between_moves: float = 800.0
var time_since_last_move: float = 0
var speed: float = 1000.0
var move_dir: Vector2 = Vector2.RIGHT
var snake_parts: Array[SnakePart] = []
var score: int:
	get:
		return score
	set(value):
		score = value
		hud.update_score(value)

func _ready() -> void:
	head.food_eaten.connect(_on_food_eaten)
	head.collided_with_tail.connect(_on_tail_collided)
	spawner.tail_added.connect(_on_tail_added)
	
	time_since_last_move = time_between_moves
	spawner.spawn_food()
	snake_parts.push_back(head)
	
func _process(delta: float) -> void:
	var _bidon = delta
	var new_dir: Vector2 = Vector2.ZERO
	
	if Input.is_action_pressed("ui_up"):
		new_dir = Vector2.UP 					# (0, -1)
	if Input.is_action_pressed("ui_right"):
		new_dir = Vector2.RIGHT				# (1, 0)
	if Input.is_action_pressed("ui_down"):
		new_dir = Vector2.DOWN					# (0, 1)
	if Input.is_action_pressed("ui_left"):
		new_dir = Vector2.LEFT					# (-1, 0)

	if new_dir + move_dir != Vector2.ZERO and new_dir != Vector2.ZERO:
		move_dir = new_dir
	
	if Input.is_action_just_pressed("ui_cancel"):
		pause_game()	

func _physics_process(delta) -> void:
	time_since_last_move += delta * speed
	if time_since_last_move >= time_between_moves:
		update_snake()
		time_since_last_move = 0

func update_snake():
	var new_pos: Vector2 = head.position + move_dir * Global.GRID_SIZE
	new_pos = bounds.wrap_vector(new_pos)
	head.move_to(new_pos)
	
	for i in range(1, snake_parts.size(), 1):
		snake_parts[i].move_to(snake_parts[i-1].last_position)

func _on_food_eaten():
	# 1. Spawn more food
	spawner.call_deferred("spawn_food")
	# 2. Add tail
	spawner.call_deferred("spawn_tail", snake_parts[snake_parts.size()-1].last_position)
	# 3. increase speed
	speed += 500
	# 4. update score
	score += 1
	
func _on_tail_added(tail: Tail):
	snake_parts.push_back(tail)
	
func _on_tail_collided():
	if not gameover_menu:
		gameover_menu = gameover_scene.instantiate() as GameOver
		add_child(gameover_menu)
		gameover_menu.set_score(score) 
	
func _notification(what):
	if what == NOTIFICATION_WM_WINDOW_FOCUS_OUT:
		pause_game()

func pause_game():
	if not pause_menu:
		pause_menu = pausemenu_scene.instantiate() as PauseMenu
		add_child(pause_menu)
