extends CharacterBody2D

@onready var sprite = $Sprite2D
@onready var movement_component = $MovementComponent
@onready var animation_player = $AnimationPlayer


var direction: Vector2 = Vector2.ZERO

func _physics_process(delta):
	
	var desired_velocity = movement_component.desired_velocity()
	
	if desired_velocity.x<0 :
		sprite.flip_h = true
		animation_player.play("run_right")
	elif desired_velocity.x >0:
		sprite.flip_h = false
		animation_player.play("run_right")
	elif desired_velocity.x == 0 and desired_velocity.y < 0:
		animation_player.play("run_up")
	elif desired_velocity.x == 0 and desired_velocity.y > 0:
		animation_player.play("run_down")
			
	else:
		animation_player.play("idle_down")
	
	var steering_vector = desired_velocity - velocity	
	velocity += steering_vector * movement_component.drag_factor
	move_and_slide()
	
	

