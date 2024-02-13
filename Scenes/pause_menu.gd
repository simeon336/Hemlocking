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
@onready var backButton = $Back
@onready var potion_info = $potionInfo
@onready var seed_info = $seedInfo

var seeds : int
var stems : int
var potions : int



func _process(delta):
	load_game()
	
	if seeds == 0 :
		seedButton.visible = false

	if stems == 0:
		stemButton.visible = false
	
	if potions == 0:
		potionButton.visible = false
	
	if seeds == 0 and stems == 0 and potions == 0:
		resumeButton.visible = true
	
func _on_resume_pressed():
	quitButton.visible = true
	itemsButton.visible = true
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
	backButton.visible = true

func _on_potion_pressed():
	emit_signal("potion")
	resumeButton.visible = true
	quitButton.visible = true
	potionButton.visible = false
	seedButton.visible = false
	stemButton.visible = false
	itemsButton.visible = true
	backButton.visible = false


func _on_seed_pressed():
	emit_signal("seed")
	resumeButton.visible = true
	quitButton.visible = true
	potionButton.visible = false
	seedButton.visible = false
	stemButton.visible = false
	itemsButton.visible = true
	backButton.visible = false


func _on_stem_pressed():
	emit_signal("stem")
	resumeButton.visible = true
	quitButton.visible = true
	potionButton.visible = false
	seedButton.visible = false
	stemButton.visible = false
	itemsButton.visible = true
	backButton.visible = false

func load_game():
	if not FileAccess.file_exists("res://SaveFiles/playersave.json"):
		return  # Error! We don't have a save to load.

	var save_game = FileAccess.open("res://SaveFiles/playersave.json", FileAccess.READ)

	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()
		var json = JSON.new()
		
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
			
			
		var node_data = json.get_data()
		
		# Update position if it exists in the saved data

		
		seeds = node_data["seeds"]
		stems = node_data["stems"]
		potions = node_data["potions"]
		
		save_game.close()


func _on_back_pressed():
	resumeButton.visible = true
	quitButton.visible = true
	potionButton.visible = false
	seedButton.visible = false
	stemButton.visible = false
	itemsButton.visible = true
	backButton.visible = false
