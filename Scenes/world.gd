extends Node2D

@onready var pause_menu = $Player/Camera2D/PauseMenu
@onready var enemy = $Enemy
@onready var player = $Player
@onready var progress_bar = $CanvasLayer/ProgressBar
@onready var hole = $Hole
@onready var hole_2 = $Hole2
@onready var plant = $Plant
@onready var harvestButton = $Harvest
@onready var log = $Log
@onready var thirst = $Thirst
@onready var waterButton = $Water
@onready var rock = $Rock
@onready var pick_up = $PickUp
@onready var teleport = $Teleport
@onready var tpButton = $TpButton 
@onready var win_hole = $WinHole



func _ready():
	print(enemy.max_hp)
	pause_menu.resume.connect(_on_resume_pressed)
	pause_menu.quit.connect(_on_quit_pressed)
	pause_menu.potion.connect(_on_potion_pressed)
	pause_menu.seed.connect(_on_seed_pressed)
	pause_menu.stem.connect(_on_stem_pressed)
	plant.start_harvest.connect(_show_harvest)
	plant.stop_harvest.connect(_hide_harvest)
	harvestButton.pressed.connect(_harvest)
	log.entered.connect(_entered_log)
	log.exited.connect(_exited_log)
	teleport.entered.connect(_show_tp)
	teleport.exited.connect(_hide_tp)
	rock.entered.connect(_on_rock_entered)
	rock.exited.connect(_on_rock_exited)
	pick_up.pressed.connect(_take_rock)
	tpButton.pressed.connect(_tp_pressed)
	waterButton.pressed.connect(_on_water_pressed)
	hole.entered.connect(_on_hole_entered)
	hole_2.entered2.connect(_on_hole2_entered)
	win_hole.winscreen.connect(_win)
	
	if enemy != null:
		if enemy.hp <= 0:
			player.blood_vials += 1
			player.save_game()
			var dir = DirAccess.open("user://")
			if dir != null:
				dir.remove("enemydata.save")
				print("remove")
			enemy.queue_free()
			print("bruh")
			
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		set_is_paused(true)
		
func _on_potion_pressed():
	player.heal(50)
	player.potion -= 1
	player.save_game()

func _on_seed_pressed():
	player.eat_seed()

func _on_stem_pressed():
	player.eat_stem()
	
func set_is_paused(is_paused: bool):
	if is_paused:
		pause_menu.show()
		Engine.time_scale = 0
	else:
		pause_menu.hide()
		Engine.time_scale = 1

func _on_water_pressed():
	player.blood_vials -= 1
	get_tree().change_scene_to_file("res://Scenes/world3.tscn")

func _entered_log():
	thirst.visible = true
	if player.blood_vials > 0:
		waterButton.visible = true

func _on_hole_entered():
	get_tree().change_scene_to_file("res://Scenes/world2.tscn")

func _on_hole2_entered():
	get_tree().change_scene_to_file("res://Scenes/world4.tscn")

func _exited_log():
	thirst.visible = false
	waterButton.visible = false
	
func _show_harvest():
	if player.blood_vials > 0:
		harvestButton.visible = true
		
func _hide_harvest():
	harvestButton.visible = false

func _harvest():
	player.stems += 3
	player.seeds += 2
	player.blood_vials -= 1
	harvestButton.visible = false
	plant.queue_free()
	player.save_game()
	
func _show_tp():
	if enemy == null:
		tpButton.visible = true
	
func _hide_tp():
	tpButton.visible = false

func _tp_pressed():
	player.position.x = 579
	player.position.y = -150
	
func _take_rock():
	player.rocks += 1
	pick_up.visible = false
	rock.queue_free()

func _on_rock_entered():
	pick_up.visible = true

func _on_rock_exited():
	pick_up.visible = false

func _on_resume_pressed():
	set_is_paused(false)

func _on_quit_pressed():
	get_tree().quit()

func _win():
	get_tree().change_scene_to_file("res://Scenes/WinScreen.tscn")
	print("win")
