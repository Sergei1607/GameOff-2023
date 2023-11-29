extends Node

signal key_selected_signal(key)
signal key_changed_signal(key)	
signal note_selected_signal(note)	



	
func _ready():
	connect("key_selected_signal", assing_key_selected)
	connect("key_changed_signal", key_changed)
	connect("note_selected_signal", assing_note_selected)
	
var key_selected: String
var current_key: String = "nothing"
var note_selected: String
var key_number_of_clicks: int
var note_number_of_clicks: int

func assing_key_selected(key):
	key_selected = key
	
func key_changed(key):
	current_key = key
	
func assing_note_selected(note):
	note_selected = note
