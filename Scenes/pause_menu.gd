extends Control

signal resume
signal quit
signal potion
signal seed
signal stem
var save_path = "user://playerdata.save"
@onready var resumeButton = $MarginContainer/VBoxContainer/Resume
@onready var quitButton = $MarginContainer/VBoxContainer/Quit
@onready var itemsButton = $MarginContainer/VBoxContainer/Items
@onready var potionButton = $Potion
@onready var seedButton = $Seed
@onready var stemButton = $Stem
@onready var backButton = $Back
@onready var potion_info = $potionInfo
@onready var seed_info = $seedInfo
@onready var stem_info = $stemInfo

var max_hp : int = 100
var hp : int = max_hp
var defense : int = 0
var attack : int = 20
var is_in_combat : bool = false
var toxicity : float = 0
var seeds : int = 0
var stems : int = 0
var potions : int = 0
var blood_vials : int = 0
var rocks : int = 0
func _ready():
	potionButton.pressed.connect(_on_potion_pressed)
	potionButton.mouse_entered.connect(_show_potion_info)
	potionButton.mouse_exited.connect(_hide_potion_info)
	itemsButton.pressed.connect(_on_items_pressed)
	seedButton.pressed.connect(_on_seed_pressed)
	seedButton.mouse_entered.connect(_show_seed_info)
	seedButton.mouse_exited.connect(_hide_seed_info)
	stemButton.pressed.connect(_on_stem_pressed)
	stemButton.mouse_entered.connect(_show_stem_info)
	stemButton.mouse_exited.connect(_hide_stem_info)
	resumeButton.pressed.connect(_on_resume_pressed)
	quitButton.pressed.connect(_on_quit_pressed)
	backButton.pressed.connect(_on_back_pressed)
	
func _process(delta):
	load_game()
	if seeds == 0 :
		seedButton.visible = false

	if stems == 0:
		stemButton.visible = false
	
	if potions == 0:
		potionButton.visible = false
	
	
func _show_potion_info():
	potion_info.visible = true

func _hide_potion_info():
	potion_info.visible = false
	
func _show_seed_info():
	seed_info.visible = true

func _hide_seed_info():
	seed_info.visible = false
	
func _show_stem_info():
	stem_info.visible = true

func _hide_stem_info():
	stem_info.visible = false
	
func _on_resume_pressed():
	quitButton.visible = true
	itemsButton.visible = true
	emit_signal("resume")


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
	potion_info.visible = false


func _on_seed_pressed():
	emit_signal("seed")
	resumeButton.visible = true
	quitButton.visible = true
	potionButton.visible = false
	seedButton.visible = false
	stemButton.visible = false
	itemsButton.visible = true
	backButton.visible = false
	seed_info.visible = false


func _on_stem_pressed():
	emit_signal("stem")
	resumeButton.visible = true
	quitButton.visible = true
	potionButton.visible = false
	seedButton.visible = false
	stemButton.visible = false
	itemsButton.visible = true
	backButton.visible = false
	stem_info.visible = false

func load_game():
	var file = FileAccess.open(save_path, FileAccess.READ)
	if file != null:
		max_hp = file.get_var(max_hp)
		hp = file.get_var(hp)
		defense = file.get_var(defense)
		attack = file.get_var(attack)
		is_in_combat = file.get_var(is_in_combat)
		toxicity = file.get_var(toxicity)
		seeds = file.get_var(seeds)
		stems = file.get_var(stems)
		potions = file.get_var(potions)
		blood_vials = file.get_var(blood_vials)
		rocks = file.get_var(rocks)

func _on_back_pressed():
	resumeButton.visible = true
	quitButton.visible = true
	potionButton.visible = false
	seedButton.visible = false
	stemButton.visible = false
	itemsButton.visible = true
	backButton.visible = false
