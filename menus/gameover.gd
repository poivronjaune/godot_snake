class_name GameOver extends CanvasLayer

@onready var score: Label = %ScoreLabel
@onready var high_score_label = %HighScoreLabel
@onready var restar: Button = %RestarButton
@onready var quit: Button = %QuitButton

func set_score(n: int):
	score.text = "Final score: " + str(n)
	if n > Global.save_data.high_score:
		high_score_label.visible = true
		Global.save_data.high_score = n
		Global.save_data.save()
	else:
		high_score_label.visible = false

func _on_restar_button_pressed() -> void:
	get_tree().reload_current_scene()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
	
func _notification(what):
	match what:
		NOTIFICATION_ENTER_TREE:
			get_tree().paused = true
		NOTIFICATION_EXIT_TREE:
			get_tree().paused = false
