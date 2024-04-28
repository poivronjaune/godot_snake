class_name StartScreen extends CanvasLayer

const gameplay_scene: PackedScene = preload("res://gameplay/gameplay.tscn")

@onready var score: Label = %ScoreLabel
@onready var start: Button = %StartButton
@onready var quit: Button = %QuitButton

func _ready():
	var high_score:int = Global.save_data.high_score
	score.text = "High Score: " + str(high_score)

func _on_start_button_pressed():
	get_tree().change_scene_to_packed(gameplay_scene)
	
func _on_quit_button_pressed():
	get_tree().quit()
