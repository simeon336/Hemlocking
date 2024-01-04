extends Control

@onready var main = $"res://Scenes/world.tscn"

#nameri kak da vzemesh main 
func _on_resume_pressed():
	main.pauseMenu()
	


func _on_quit_pressed():
	get_tree().quit
