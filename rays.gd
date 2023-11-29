extends ColorRect


	
func _physics_process(delta):
	
	if GameEvents.game_completed:
		self.material.set_shader_parameter("falloff", lerp(self.material.get_shader_parameter("falloff"), 0.0, 0.005))
	

	
	
	
	
