extends Node2D



func _on_area_2d_body_entered(body):
	if body.name == "Player":
		if body.z_index == 0:
			body.z_index = 1
			body.set_collision_mask_value(5, true)
			body.set_collision_mask_value(6, false)
		elif body.z_index == 1:
			body.z_index = 0
			body.set_collision_mask_value(5, false)
			body.set_collision_mask_value(6, true)
			
	
