extends Node2D

@onready var audio_stream_player = $AudioStreamPlayer
@onready var audio_stream_player_2 = $AudioStreamPlayer2
@onready var player = $Player
@onready var rays = $Rays
@onready var introduction = $Introduction
@onready var end_screen = $EndScreen
var game_started: bool = false


func _ready():
	GameEvents.connect("game_completed_signal", game_completed)
	player.process_mode = PROCESS_MODE_DISABLED
	
func _process(_delta):
	if GameEvents.pentagram_active:
		audio_stream_player.volume_db = -20
		player.set_physics_process(false)
	else:
		audio_stream_player.volume_db = 0
		player.set_physics_process(true)
		
	if Input.is_action_just_pressed("click") and !game_started:
		introduction.queue_free()
		game_started= true
		player.process_mode = Node.PROCESS_MODE_INHERIT
		

func game_completed():
	player.process_mode = PROCESS_MODE_DISABLED
	audio_stream_player.playing = false
	audio_stream_player_2.playing = true
	
	

