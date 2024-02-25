extends Node2D
@onready var respawn = $Respawn

func _ready():
	respawn.pressed.connect(_on_respawn_pressed)

func _on_respawn_pressed():
	var dir = DirAccess.open("user://")
	if dir.file_exists("user://playerdata.save"):
		dir.remove("playerdata.save")
	if dir.file_exists("user://enemydata.save"):
		dir.remove("enemydata.save")
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
