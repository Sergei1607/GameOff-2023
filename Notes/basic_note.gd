extends Node2D

@onready var sprite_2d = $Sprite2D
@onready var shadow = $Shadow
@onready var audio = $AudioStreamPlayer

func move_toward_player(percent: float, note_start_position: Vector2, body:CharacterBody2D):
	
	if body.name != "Player":
		return
		
	global_position = note_start_position.lerp(body.global_position, percent)
	
	var direction_to_player_from_start_position = body.global_position - note_start_position
	
func execute_move_toward_player(body):
	
	var tween = create_tween()
	shadow.visible = false
	
	# with tween parallel both tweens will start at the same time
	tween.set_parallel()
	
	# we call the move_toward_player function. The first argument will be a value between
	# 0.0 and 1.0 with a duration of 0.5, the second argument is the global position of the note
	# and the thirt argument is the body. We use tween method and .bind to do this. 
	
	tween.tween_method(move_toward_player.bind(global_position, body), 0.0, 1.0, 0.4).set_ease(Tween.EASE_IN)
	tween.tween_property(sprite_2d, "scale", Vector2.ZERO, 0.3).set_delay(0.4)
	await tween.finished
	audio.play()
	add_note_to_count()
	await get_tree().create_timer(1).timeout
	queue_free()
	
func add_note_to_count():
	GameEvents.global_note_count += 1
	GameEvents.global_note_count_update.emit()
	
func _on_area_2d_body_entered(body):
	if body.name == "Player":
		execute_move_toward_player(body)
	
