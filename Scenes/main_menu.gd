extends Control
signal quit


func _on_new_game_button_pressed():
	var dir = DirAccess.open("user://")
	if dir.file_exists("user://playerdata.save"):
		dir.remove("playerdata.save")
	if dir.file_exists("user://enemydata.save"):
		dir.remove("enemydata.save")
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func _on_load_game_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

	
func _on_quit_button_pressed():
	emit_signal("quit")
