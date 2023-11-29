extends StaticBody2D

@onready var close = $Close
@onready var open = $Open
@onready var gpu_particles_2d = $GPUParticles2D
@onready var click = $Click

var ready_to_click: bool = false
var player_near: bool = false 


func _physics_process(delta):
	if !GameEvents.chest_open:
		close.visible = true
		open.visible = false
		gpu_particles_2d.emitting = false
	else:
		close.visible = false
		open.visible = true
		gpu_particles_2d.emitting = true
		if Input.is_action_just_pressed("click") and player_near and ready_to_click:
			GameEvents.game_completed_signal.emit()
			GameEvents.game_completed = true

func _on_area_2d_mouse_entered():
	if GameEvents.chest_open:
		ready_to_click = true


func _on_area_2d_mouse_exited():
	ready_to_click = false


func _on_area_2d_body_entered(body):
	if body.name == "Player" and GameEvents.chest_open:
		click.visible = true
		player_near = true

func _on_area_2d_body_exited(body):
	if body.name == "Player" :
		click.visible = false
		player_near = false
