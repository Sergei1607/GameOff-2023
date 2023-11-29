extends Control

@onready var control_1 = $Control
@onready var control_2 = $Control2
@onready var control_3 = $Control3
@onready var control_4 = $Control4
@onready var control_5 = $Control5



var control_array: Array
var local_amount_of_counts: int = GameEvents.global_note_count

func _ready():
	control_array.append(control_1)
	control_array.append(control_2)
	control_array.append(control_3)
	control_array.append(control_4)
	control_array.append(control_5)
	
	for i in GameEvents.global_note_count:
		control_array[i].visible = true
	
	
	
