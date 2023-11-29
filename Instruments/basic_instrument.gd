extends Node2D

@onready var audio_stream_player = $AudioStreamPlayer


func _on_area_2d_area_entered(area):
	if area.get_parent().name == "MagicBall":
		audio_stream_player.play()
