extends Node2D

@onready var path_follow:PathFollow2D = get_parent()
@onready var sprite = $Sprite2D

var speed: int = 300

var move_magic_ball: bool = false

func _physics_process(delta):
	if move_magic_ball:
		path_follow.set_progress(path_follow.get_progress() + speed * delta)
