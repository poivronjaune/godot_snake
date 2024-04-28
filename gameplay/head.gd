class_name Head extends SnakePart

signal food_eaten
signal collided_with_tail

func _on_area_entered(area):
	print("Collided with ", area.name)
	if area.is_in_group("Food"):
		# Collision with food
		food_eaten.emit()
		area.call_deferred("queue_free")
	else:
		# Collision with something else, our Tail
		collided_with_tail.emit()
		
