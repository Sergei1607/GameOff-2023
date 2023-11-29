extends StaticBody2D

@onready var door_closed = $DoorClosed
@onready var door_open = $DoorOpen
@onready var collision_shape_2d = $CollisionShape2D


func _ready():
	GameEvents.connect("pentagram_three_completed", on_pentagram_three_completed)
	
func on_pentagram_three_completed():
	door_closed.visible = false
	door_open.visible = true
	collision_shape_2d.set_deferred("disabled",true)
