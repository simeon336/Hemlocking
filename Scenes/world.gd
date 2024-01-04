extends Node2D
@onready var pause_menu = $Player/Camera2D/PauseMenu


# Called when the node enters the scene tree for the first time.
func _ready():
	set_is_paused(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		set_is_paused(true)
		
func set_is_paused(is_paused : bool):
	if is_paused:
		pause_menu.show()
		Engine.time_scale = 0
	else:
		pause_menu.hide()
		Engine.time_scale = 1
	
