extends Node2D

var note_available_to_grab: bool = false
var rest_point: Vector2 = Vector2.ZERO
var inicial_rest_point: Vector2 = global_position
var rest_nodes: Array = []
var distance_to_dropzone: float = 0.0
var distance_to_dropzones_array: Array = []
var count: int = 0
var count_for_unlock: int = 0
var current_drop_zone: String = ""
var on_drop_zone: bool = false
var chosen_drop_zone
var note_on_click = false 
var note_drop_zone_dictionary: Dictionary

@onready var note_drop_zone_1 = $"../../DropZones/NoteDropZone1"
@onready var note_drop_zone_2 = $"../../DropZones/NoteDropZone2"
@onready var note_drop_zone_3 = $"../../DropZones/NoteDropZone3"
@onready var note_drop_zone_4 = $"../../DropZones/NoteDropZone4"
@onready var note_drop_zone_5 = $"../../DropZones/NoteDropZone5"
@onready var collision = $MouseEntered/CollisionShape2D

func _ready():
	rest_nodes = get_tree().get_nodes_in_group("NoteDropZone")
	rest_point = global_position
	inicial_rest_point = global_position
	modulate = Color(1,1,1,0)
	current_drop_zone = "base"
	GameEvents.local_note_count = GameEvents.global_note_count
	collision.disabled = true
	
	note_drop_zone_dictionary = {note_drop_zone_1: {"locked":note_drop_zone_1.locked, "note": null},
	note_drop_zone_2: {"locked":note_drop_zone_2.locked, "note": null}, 
	note_drop_zone_3: {"locked":note_drop_zone_3.locked, "note": null},
	note_drop_zone_4: {"locked":note_drop_zone_4.locked, "note": null},
	note_drop_zone_5: {"locked":note_drop_zone_5.locked, "note": null}}
	
			
func _physics_process(delta):
	
	if !get_parent().get_parent().magic_ball_moving:
		if Input.is_action_just_pressed("click"):
			if ControllerEvents.note_number_of_clicks == 0:
				take_note()
			elif ControllerEvents.note_number_of_clicks == 1:
				drop_note()
			
		if note_on_click and ControllerEvents.note_selected == self.name:
	
			global_position = get_global_mouse_position()
			modulate = Color(1,1,1,0.5)
	
		else:
			global_position = lerp(global_position, rest_point, 10 * delta)
		
		if round(global_position) == round(inicial_rest_point): 
			modulate = Color(1,1,1,0)
		
func take_note():
	if note_available_to_grab:
		ControllerEvents.note_selected_signal.emit(self.name)
		note_on_click = true
		ControllerEvents.note_number_of_clicks = 1
			
func drop_note():

	if ControllerEvents.note_selected == self.name:
		
		count = 0
		count_for_unlock = 0
		distance_to_dropzones_array = []
		chosen_drop_zone = null
			
		for dropZone in rest_nodes:
			distance_to_dropzone = global_position.distance_to(dropZone.global_position)
			distance_to_dropzones_array.append(distance_to_dropzone)
			
			
		for distance in distance_to_dropzones_array:
			if distance <50:
				chosen_drop_zone = rest_nodes[count]
			count += 1
			
		if ControllerEvents.current_key != "nothing":
		
			if chosen_drop_zone == null and current_drop_zone == "NoteDropZone":
				move_to_initial_point()
			
			elif chosen_drop_zone == null and current_drop_zone == "base":
				rest_point = inicial_rest_point
				current_drop_zone = "base"
				note_on_click = false
				ControllerEvents.note_number_of_clicks = 0
			
			elif chosen_drop_zone != null and current_drop_zone == "base" and !chosen_drop_zone.locked:
				chosen_drop_zone.lock()
				rest_point = chosen_drop_zone.global_position
				modulate = Color(1,1,1,1)
				GameEvents.local_note_count -= 1
				current_drop_zone = "NoteDropZone"
				note_on_click = false
				ControllerEvents.note_number_of_clicks = 0
				note_drop_zone_dictionary[chosen_drop_zone]["note"] = ControllerEvents.note_selected
			
			elif chosen_drop_zone != null and current_drop_zone == "NoteDropZone" and !chosen_drop_zone.locked:
			
				for i in note_drop_zone_dictionary.values():
					if i["note"] == ControllerEvents.note_selected:
						note_drop_zone_dictionary.find_key(i).unlock()
						note_drop_zone_dictionary[note_drop_zone_dictionary.find_key(i)]["note"] = null
						

				chosen_drop_zone.lock()
				rest_point = chosen_drop_zone.global_position
				modulate = Color(1,1,1,1)
				note_on_click = false
				ControllerEvents.note_number_of_clicks = 0
				note_drop_zone_dictionary[chosen_drop_zone]["note"] = ControllerEvents.note_selected
			
		else:
			rest_point = inicial_rest_point
			current_drop_zone = "base"
			note_on_click = false
			ControllerEvents.note_number_of_clicks = 0
			
func move_to_initial_point():
	if !round(global_position) == round(inicial_rest_point): 
		rest_point = inicial_rest_point
		GameEvents.local_note_count += 1
		current_drop_zone = "base"
		note_on_click = false
		ControllerEvents.note_number_of_clicks = 0
	
		
func _on_area_2d_mouse_entered():
	if current_drop_zone == "base":
		if GameEvents.local_note_count > 0 and get_parent().get_parent().current_key != "nothing":
			note_available_to_grab = true
	elif current_drop_zone == "NoteDropZone":
		note_available_to_grab = true

func _on_area_2d_2_mouse_exited():
	note_available_to_grab = false
