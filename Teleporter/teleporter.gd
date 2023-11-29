extends Node2D


@onready var click = $Click

@export var spawn_location: Vector2
@export var player: CharacterBody2D
@export var functional: bool
@export var animation_player: AnimationPlayer
@onready var base_activated = $BaseActivated
@onready var audio = $AudioStreamPlayer

var player_near: bool = false
var ready_to_click : bool = false

func _physics_process(delta):
	if Input.is_action_just_pressed("click") and player_near and ready_to_click:
		animation_player.play("Fade")
		audio.play()
		player.global_position = spawn_location
		


func _on_area_2d_body_entered(body):
	if body.name == "Player" and functional:
		click.visible = true
		player_near = true
		base_activated.visible = true


func _on_area_2d_body_exited(body):
	if body.name == "Player" :
		click.visible = false
		player_near = false
		base_activated.visible = false


func _on_area_2d_mouse_entered():
	ready_to_click = true


func _on_area_2d_mouse_exited():
	ready_to_click = false
