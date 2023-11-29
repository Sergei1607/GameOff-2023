extends Marker2D

var locked: bool = true
var magic_ball_passed: bool = false

@export var sound1:AudioStreamPlayer

func _ready():
	visible = false

func _draw():
	draw_circle(Vector2.ZERO, 15, Color.MEDIUM_PURPLE)
	
func lock():
	locked = true
	visible = false

func unlock():
	locked = false
	visible = true
	
	
func _on_area_2d_area_entered(area):
	if area.get_parent().name == "MagicBall":
		magic_ball_passed = true


func _on_areaformusic_area_entered(area):
	if area.get_parent().name == "MagicBall" and locked:
			sound1.playing = true
		
