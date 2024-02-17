extends Control
signal quit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_new_game_button_pressed():
	var dir = DirAccess.open("res://SaveFiles/")
	var save_files = ["playersave.json", "enemysave.json", "enemy2save.json", "enemy3save.json", "enemy4save.json"]
	for save_file in save_files:
		var path = "user://SaveFiles/" + save_file
		if FileAccess.file_exists(path):
			dir.remove(path)
			print("removed file" + path)
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func _on_load_game_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

	
func _on_quit_button_pressed():
	emit_signal("quit")
