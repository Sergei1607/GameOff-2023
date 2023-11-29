extends Node2D

var key_available_to_grab: bool = false
var rest_point: Vector2 = Vector2.ZERO
var inicial_rest_point: Vector2 = global_position
var rest_node: Node2D
var distance_to_dropzone: float = 0.0
var current_drop_zone: String = ""
var key_on_click = false 

func _ready():
	rest_node = get_tree().get_first_node_in_group("KeyDropZone")
	rest_point = global_position
	inicial_rest_point = global_position
	modulate = Color(1,1,1,0)
	current_drop_zone = "base"


func _physics_process(delta):
	
	if !get_parent().get_parent().magic_ball_moving:
	
		if Input.is_action_just_pressed("click"):
			if ControllerEvents.key_number_of_clicks == 0:
				take_key()
			elif ControllerEvents.key_number_of_clicks == 1:
				drop_key()

		if key_on_click and ControllerEvents.key_selected == self.name:

			global_position = get_global_mouse_position()
			modulate = Color(1,1,1,0.5)

		else:
			global_position = lerp(global_position, rest_point, 10 * delta)

		if round(global_position) == round(inicial_rest_point): 
			modulate = Color(1,1,1,0)

func take_key():
	if key_available_to_grab and (ControllerEvents.current_key == "nothing" or ControllerEvents.current_key == self.name):
		ControllerEvents.key_selected_signal.emit(self.name)
		key_on_click = true
		ControllerEvents.key_number_of_clicks = 1


func drop_key():

	if ControllerEvents.key_selected == self.name:
		distance_to_dropzone = global_position.distance_to(rest_node.global_position)

		if distance_to_dropzone < 50 and !rest_node.locked and current_drop_zone == "base":
			rest_node.lock()
			rest_point = rest_node.global_position
			modulate = Color(1,1,1,1)
			current_drop_zone = "KeyDropZone"	
			ControllerEvents.key_changed_signal.emit(self.name)
			key_on_click = false
			ControllerEvents.key_number_of_clicks = 0

		elif distance_to_dropzone < 100 and current_drop_zone == "KeyDropZone":
			rest_node.lock()
			rest_point = rest_node.global_position
			modulate = Color(1,1,1,1)
			key_on_click = false
			ControllerEvents.key_number_of_clicks = 0

		else:
			rest_node.unlock()
			rest_point = inicial_rest_point
			current_drop_zone = "base"	
			ControllerEvents.key_selected = "nothing"
			ControllerEvents.key_changed_signal.emit("nothing")
			key_on_click = false
			ControllerEvents.key_number_of_clicks = 0

func _on_area_2d_mouse_entered():
	if self.name == "F" and GameEvents.f_key_unlocked:
		key_available_to_grab = true
	if self.name == "C" and GameEvents.c_key_unlocked:
		key_available_to_grab = true
	if self.name == "G":
		key_available_to_grab = true


func _on_area_2d_2_mouse_exited():
	key_available_to_grab = false


	

	

