extends Node2D

signal closed
@onready var path_follow_2d = $Path2D/PathFollow2D
@onready var magic_ball = $Path2D/PathFollow2D/MagicBall
@onready var note_drop_zone_1 = $DropZones/NoteDropZone1
@onready var note_drop_zone_2 = $DropZones/NoteDropZone2
@onready var note_drop_zone_3 = $DropZones/NoteDropZone3
@onready var note_drop_zone_4 = $DropZones/NoteDropZone4
@onready var final = $CanvasLayer/Final



@onready var key_drop_zone = $DropZones/KeyDropZone
@onready var note_1 = $Notes/Note1
@onready var note_2 = $Notes/Note2
@onready var note_3 = $Notes/Note3
@onready var note_4 = $Notes/Note4


var magic_ball_moving: bool = false
var note_drop_zones: Array = []
var current_key: String = "nothing"
var notes_array: Array


func _ready():
	ControllerEvents.connect("key_changed_signal", key_changed)
	note_drop_zones = get_tree().get_nodes_in_group("NoteDropZone")
	notes_array.append(note_1)
	notes_array.append(note_2)
	notes_array.append(note_3)
	notes_array.append(note_4)
	
	for i in GameEvents.global_note_count:
		notes_array[i].collision.disabled = false
		
func key_changed(name):
	if current_key == "nothing":
		if name == "G":
			for drop in note_drop_zones:
				drop.unlock()
				current_key = "G"
				key_drop_zone.visible = false
				
		elif name == "F":
			for drop in note_drop_zones:
				drop.unlock()
				drop.global_position = drop.global_position + Vector2(0 , -80)
				current_key = "F"
				key_drop_zone.visible = false
	elif current_key == "G":
		if name == "nothing":
			for drop in note_drop_zones:
				drop.lock()
				current_key = "nothing"
				key_drop_zone.visible = true
			note_1.move_to_initial_point()
			note_2.move_to_initial_point()
			note_3.move_to_initial_point()
			note_4.move_to_initial_point()
	elif current_key == "F":
		if name == "nothing":
			for drop in note_drop_zones:
				drop.lock()
				current_key = "nothing"
				drop.global_position = drop.global_position + Vector2(0 , 80)
				key_drop_zone.visible = true
			note_1.move_to_initial_point()
			note_2.move_to_initial_point()
			note_3.move_to_initial_point()
			note_4.move_to_initial_point()
	
func _on_check_point_1_area_entered(area):
	
	if area.get_parent().name == "MagicBall":

		if  !note_drop_zone_1.locked or !note_drop_zone_1.magic_ball_passed:
			path_follow_2d.set_progress(0.0)
			magic_ball.move_magic_ball = false
			magic_ball_moving = false
			magic_ball.sprite.visible = false

func _on_check_point_2_area_entered(area):
	
	if area.get_parent().name == "MagicBall":

		if  !note_drop_zone_2.locked or !note_drop_zone_2.magic_ball_passed:
			path_follow_2d.set_progress(0.0)
			magic_ball.move_magic_ball = false
			magic_ball_moving = false
			magic_ball.sprite.visible = false

func _on_check_point_3_area_entered(area):
	if area.get_parent().name == "MagicBall":

		if  !note_drop_zone_3.locked or !note_drop_zone_3.magic_ball_passed:
			path_follow_2d.set_progress(0.0)
			magic_ball.move_magic_ball = false
			magic_ball_moving = false
			magic_ball.sprite.visible = false
			
func _on_check_point_4_area_entered(area):
	if area.get_parent().name == "MagicBall":

		if  !note_drop_zone_4.locked or !note_drop_zone_4.magic_ball_passed:
			path_follow_2d.set_progress(0.0)
			magic_ball.move_magic_ball = false
			magic_ball_moving = false
			magic_ball.sprite.visible = false
			
func _on_check_point_5_area_entered(area):
	if area.get_parent().name == "MagicBall":
		GameEvents.pentagram_three_completed.emit()
		GameEvents.pentagram_completed_signal.emit(self.name)
		show_final_message()

			
func _on_button_pressed():
	if current_key != "nothing":
		magic_ball.sprite.visible = true
		magic_ball.move_magic_ball = true
		magic_ball_moving = true
				
func _on_quit_pressed():
	GameEvents.pentagram_active = false
	ControllerEvents.current_key = "nothing"
	queue_free()


func show_final_message():
	final.visible = true




