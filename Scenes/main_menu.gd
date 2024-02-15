extends Control
signal quit


func _ready():
	pass 

func _process(delta):
	pass


func _on_new_game_button_pressed():
	var dir = DirAccess.open("user://SaveFiles/")
	dir.remove("user://SaveFiles/playersave.json")
	dir.remove("user://SaveFiles/enemysave.json")
	dir.remove("user://SaveFiles/enemy2save.json")
	dir.remove("user://SaveFiles/enemy3save.json")
	dir.remove("user://SaveFiles/enemy4save.json")
	get_tree().change_scene_to_file("user://Scenes/world.tscn")

func _on_load_game_button_pressed():
	get_tree().change_scene_to_file("user://Scenes/world.tscn")

	
func _on_quit_button_pressed():
	emit_signal("quit")
