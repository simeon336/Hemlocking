extends Node2D

@onready var pause_menu = $Player/Camera2D/PauseMenu

# Called when the node enters the scene tree for the first time.
func _ready():
	pause_menu.resume.connect(_on_resume_pressed)
	pause_menu.quit.connect(_on_quit_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		set_is_paused(true)

func set_is_paused(is_paused: bool):
	print("pause")
	if is_paused:
		pause_menu.show()
		Engine.time_scale = 0
	else:
		pause_menu.hide()
		Engine.time_scale = 1

func _on_resume_pressed():
	set_is_paused(false)

func _on_quit_pressed():
	get_tree().quit()
