extends Node2D

@onready var animation_player = $AnimationPlayer

func _ready():
	GameEvents.connect("game_completed_signal", game_completed)
	
func game_completed():
	animation_player.play("finish")
	
func show_end_screen():
	get_parent().end_screen.visible = true
	
