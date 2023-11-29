extends Control

@onready var f = $F
@onready var c = $C


func _physics_process(delta):
	if GameEvents.f_key_unlocked:
		f.visible = true
		
	if GameEvents.c_key_unlocked:
		c.visible = true
