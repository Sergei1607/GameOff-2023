extends Node

@export var speed: int = 500
@export var drag_factor : float = 0.9

func desired_velocity():
	
	var x_movement = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_movement = Input.get_action_strength("down") - Input.get_action_strength("up")
	var direction = Vector2(x_movement, y_movement).normalized()
	var desired_velocity = speed * direction 
	
	return desired_velocity
