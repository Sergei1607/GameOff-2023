extends Control


@onready var label = $MarginContainer/HBoxContainer/Label


func _ready():
	
	GameEvents.connect("global_note_count_update", update_note_count_labels)
	
	label.text = "x " + str(GameEvents.global_note_count)

func update_note_count_labels():
	label.text = "x " + str(GameEvents.global_note_count)
