
extends Line2D

@export var sprite: Sprite2D



func draw_trajectory():
	var max_points = 1
	var position: Vector2 = sprite.global_position
	for i in max_points:
		add_point(position)
			
func _physics_process(delta):
	draw_trajectory()
	
func _ready():
	#proyect_trajectory()
	pass
	
	
	
