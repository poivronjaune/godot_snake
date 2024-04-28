class_name Spawner extends Node2D

signal tail_added(tail: Tail)

@export var bounds: Bounds
# Instantiate packed scenes
var food_scene: PackedScene = preload("res://gameplay/food.tscn")
var tail_scene: PackedScene = preload("res://gameplay/tail.tscn")

func spawn_food():
	# 1- Where to spawn our food (Position)
	var spawn_point: Vector2 = Vector2.ZERO
	spawn_point.x = randf_range(bounds.x_min + Global.GRID_SIZE, bounds.x_max - Global.GRID_SIZE)	
	spawn_point.y = randf_range(bounds.y_min + Global.GRID_SIZE, bounds.y_max - Global.GRID_SIZE)		
	
	spawn_point.x = floor(spawn_point.x / Global.GRID_SIZE) * Global.GRID_SIZE
	spawn_point.y = floor(spawn_point.y / Global.GRID_SIZE) * Global.GRID_SIZE
	
	# 2- What we are spawning (Instantiation)
	var food = food_scene.instantiate()
	food.position = spawn_point
	
	# 3- Where we are putting the food (Parenting)
	get_parent().add_child(food)
	
func spawn_tail(pos: Vector2):
	var tail: Tail = tail_scene.instantiate() as Tail
	tail.position = pos
	get_parent().add_child(tail)
	tail_added.emit(tail)
	
