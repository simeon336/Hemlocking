extends Control
signal quit


func _ready():
	pass 

func _process(delta):
	pass


func _on_new_game_button_pressed():
<<<<<<< HEAD
	var dir = DirAccess.open("res://SaveFiles/")
	var save_files = ["playersave.json", "enemysave.json", "enemy2save.json", "enemy3save.json", "enemy4save.json"]
	for save_file in save_files:
		var path = "user://SaveFiles/" + save_file
		if FileAccess.file_exists(path):
			dir.remove(path)
			print("removed file" + path)
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
=======
	var dir = DirAccess.open("user://SaveFiles/")
	dir.remove("user://SaveFiles/playersave.json")
	dir.remove("user://SaveFiles/enemysave.json")
	dir.remove("user://SaveFiles/enemy2save.json")
	dir.remove("user://SaveFiles/enemy3save.json")
	dir.remove("user://SaveFiles/enemy4save.json")
	get_tree().change_scene_to_file("user://Scenes/world.tscn")
>>>>>>> ce7f7940797844541d96fe3aecf36f3b6290cd46

func _on_load_game_button_pressed():
	get_tree().change_scene_to_file("user://Scenes/world.tscn")

	
func _on_quit_button_pressed():
	emit_signal("quit")
