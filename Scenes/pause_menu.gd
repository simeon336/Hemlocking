extends Control

signal resume
signal quit

func _on_resume_pressed():
	emit_signal("resume")
	print("pressedd")


func _on_quit_pressed():
	emit_signal("quit")
