extends Control
signal new_game
signal load_game
signal quit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_new_game_button_pressed():
	var dir = DirAccess.open("res://SaveFiles/")
	dir.remove("res://SaveFiles/playersave.json")
	dir.remove("res://SaveFiles/enemysave.json")
	dir.remove("res://SaveFiles/enemy2save.json")
	dir.remove("res://SaveFiles/enemy3save.json")
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func _on_load_game_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

	
func _on_quit_button_pressed():
	emit_signal("quit")
