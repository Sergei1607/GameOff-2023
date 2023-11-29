extends Node2D

@onready var p0 = $p0.global_position
@onready var p1 = $p1.global_position
@onready var p2 = $p2.global_position
@onready var p3 = $p3.global_position
@onready var p4 = $p4.global_position
@onready var p5 = $p5.global_position
@onready var p6 = $p6.global_position



@onready var sprite_2d = $Sprite2D
@onready var h_slider = $HSlider
@onready var h_slider_2 = $HSlider2

var time = 0
var time2 = 0
var curve = 1


func cubic_bezier(p0: Vector2, p1: Vector2, p2: Vector2, p3: Vector2, t: float):
	var q0 = p0.lerp(p1, t)
	var q1 = p1.lerp(p2, t)
	var q2 = p2.lerp(p3, t)

	var r0 = q0.lerp(q1, t)
	var r1 = q1.lerp(q2, t)
	
	var s1 = r0.lerp(r1, t)

	return s1
	
func cubic_bezier2(p3: Vector2, p4: Vector2, p5: Vector2, p6: Vector2, t: float):
	var q0 = p3.lerp(p4, t)
	var q1 = p4.lerp(p5, t)
	var q2 = p5.lerp(p6, t)

	var r0 = q0.lerp(q1, t)
	var r1 = q1.lerp(q2, t)
	
	var s1 = r0.lerp(r1, t)

	return s1
	
func _physics_process(delta):
		
	if curve == 1:
	
		sprite_2d.global_position = cubic_bezier(p0, p1, p2, p3, time)
		
		time += delta /4
		
		if round(sprite_2d.global_position) == round(p3):
			curve = 2
			
	elif curve == 2:
		
		sprite_2d.global_position = cubic_bezier(p3, p4, p5, p6, time2)
		
		time2 += delta /4 
		
		if round(sprite_2d.global_position) == round(p6):
			curve = 3
	
	

	

	
	
	
	

