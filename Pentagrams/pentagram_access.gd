extends Node2D

@export var pentagram_scene: PackedScene
@export var pentagram_layer: CanvasLayer
@onready var click_icon = $ClickIcon
@onready var gpu_particles_2d = $GPUParticles2D

var completed: bool = false
var player_near: bool = false
var ready_to_click : bool = false
var assigned_pentagram

func _ready():
	assigned_pentagram = pentagram_scene.instantiate()
	GameEvents.connect("pentagram_completed_signal", pentagram_completed)

func _physics_process(delta):
	
	if !completed:
		if Input.is_action_just_pressed("click") and player_near and ready_to_click:
			var child = pentagram_scene.instantiate()
			pentagram_layer.call_deferred("add_child", child)
			GameEvents.pentagram_active = true
		
			
	else:
		gpu_particles_2d.emitting = false
		click_icon.visible = false
		
	
func _on_area_2d_body_entered(body):
	if body.name == "Player" and !completed:
		click_icon.visible = true
		player_near = true
#		
func _on_area_2d_body_exited(body):
	if body.name == "Player" :
		click_icon.visible = false
		player_near = false

func _on_area_2d_mouse_entered():
	if !GameEvents.pentagram_active:
		ready_to_click = true

func _on_area_2d_mouse_exited():
	ready_to_click = false

func pentagram_completed(pentagram):
	if pentagram == assigned_pentagram.name:
		completed = true

	
