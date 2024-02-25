extends Node2D
@onready var restart = $Restart
@onready var quit = $Quit

func _ready():
	restart.pressed.connect(_on_restart_pressed)
	quit.pressed.connect(_on_quit_pressed)

func _on_restart_pressed():
	var dir = DirAccess.open("user://")
	if dir.file_exists("user://playerdata.save"):
		dir.remove("playerdata.save")
	if dir.file_exists("user://enemydata.save"):
		dir.remove("enemydata.save")
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
	
func _on_quit_pressed():
	get_tree().quit()
