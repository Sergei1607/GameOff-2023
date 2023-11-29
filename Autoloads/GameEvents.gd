extends Node

signal global_note_count_update
signal nothing_selected
signal pentagram_one_completed
signal pentagram_three_completed
signal pentagram_completed_signal(pentagram)
signal game_completed_signal


var global_note_count : int = 0
var local_note_count : int = 0
var pentagram_active: bool = false
var f_key_unlocked: bool = false
var c_key_unlocked: bool = false
var chest_open: bool = false
var game_completed: bool = false
	
	
