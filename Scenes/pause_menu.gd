extends Control

signal resume
signal quit
signal potion
signal seed
signal stem
@onready var resumeButton = $MarginContainer/VBoxContainer/Resume
@onready var quitButton = $MarginContainer/VBoxContainer/Quit
@onready var itemsButton = $MarginContainer/VBoxContainer/Items
@onready var potionButton = $Potion
@onready var seedButton = $Seed
@onready var stemButton = $Stem

func _on_resume_pressed():
	emit_signal("resume")
	print("pressedd")


func _on_quit_pressed():
	emit_signal("quit")


func _on_items_pressed():
	resumeButton.visible = false
	quitButton.visible = false
	potionButton.visible = true
	seedButton.visible = true
	stemButton.visible = true
	itemsButton.visible = false

func _on_potion_pressed():
	emit_signal("potion")
	resumeButton.visible = true
	quitButton.visible = true
	potionButton.visible = false
	seedButton.visible = false
	stemButton.visible = false
	itemsButton.visible = true


func _on_seed_pressed():
	emit_signal("seed")
	resumeButton.visible = true
	quitButton.visible = true
	potionButton.visible = false
	seedButton.visible = false
	stemButton.visible = false
	itemsButton.visible = true


func _on_stem_pressed():
	emit_signal("stem")
	resumeButton.visible = true
	quitButton.visible = true
	potionButton.visible = false
	seedButton.visible = false
	stemButton.visible = false
	itemsButton.visible = true
