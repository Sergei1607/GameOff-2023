extends Marker2D

var locked: bool = false

func _draw():
	draw_circle(Vector2.ZERO, 30, Color.MEDIUM_PURPLE)
	
func lock():
	locked = true
	
func unlock():

	locked = false
	
