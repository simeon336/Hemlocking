extends Node2D
@onready var respawn = $Respawn

func _ready():
	respawn.pressed.connect(_on_respawn_pressed)

func _on_respawn_pressed():
	var dir = DirAccess.open("user://SaveFiles/")
	dir.remove("user://SaveFiles/playersave.json")
	dir.remove("user://SaveFiles/enemysave.json")
	dir.remove("user://SaveFiles/enemy2save.json")
	dir.remove("user://SaveFiles/enemy3save.json")
	dir.remove("user://SaveFiles/enemy4save.json")
	get_tree().change_scene_to_file("user://Scenes/world.tscn")
