extends Node2D
@onready var restart = $Restart
@onready var quit = $Quit

func _ready():
	restart.pressed.connect(_on_restart_pressed)
	quit.pressed.connect(_on_quit_pressed)

func _on_restart_pressed():
	var dir = DirAccess.open("user://SaveFiles/")
	dir.remove("user://SaveFiles/playersave.json")
	dir.remove("user://SaveFiles/enemysave.json")
	dir.remove("user://SaveFiles/enemy2save.json")
	dir.remove("user://SaveFiles/enemy3save.json")
	dir.remove("user://SaveFiles/enemy4save.json")
	get_tree().change_scene_to_file("user://Scenes/world.tscn")
	
func _on_quit_pressed():
	get_tree().quit()
