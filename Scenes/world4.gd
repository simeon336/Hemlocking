extends Node2D

@onready var pause_menu = $Player/Camera2D/PauseMenu
@onready var enemy4 = $Enemy4
@onready var player = $Player
@onready var main_menu = $MainMenu
@onready var plant = $Plant
@onready var harvestButton = $Harvest
@onready var rock = $Rock
@onready var pick_up = $PickUp

var current_enemy : Node2D = null
# Called when the node enters the scene tree for the first time.
func _ready():
	player.position.x = 151
	player.position.y = 138
	pause_menu.resume.connect(_on_resume_pressed)
	pause_menu.quit.connect(_on_quit_pressed)
	pause_menu.potion.connect(_on_potion_pressed)
	pause_menu.seed.connect(_on_seed_pressed)
	pause_menu.stem.connect(_on_stem_pressed)
	plant.start_harvest.connect(_show_harvest)
	plant.stop_harvest.connect(_hide_harvest)
	harvestButton.pressed.connect(_harvest)
	rock.entered.connect(_on_rock_entered)
	rock.exited.connect(_on_rock_exited)
	pick_up.pressed.connect(_take_rock)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		set_is_paused(true)
		
	if enemy4 != null:
		if enemy4.hp <= 0:
			player.blood_vials += 1
			enemy4.queue_free()

func _on_potion_pressed():
	player.heal(50)
	player.potions -= 1
	player.print_stats()

func _show_harvest():
	if player.blood_vials > 0:
		harvestButton.visible = true
		
func _hide_harvest():
	harvestButton.visible = false

func _harvest():
	player.stems += 2
	player.seeds += 1
	player.blood_vials -= 1
	harvestButton.visible = false
	plant.queue_free()

func _on_seed_pressed():
	player.eat_seed()
	player.seeds -= 1

func _on_stem_pressed():
	player.eat_stem()
	player.stems -= 1
	
func set_is_paused(is_paused: bool):
	print("pause")
	if is_paused:
		pause_menu.show()
		Engine.time_scale = 0
	else:
		pause_menu.hide()
		Engine.time_scale = 1

func _on_resume_pressed():
	set_is_paused(false)

func _on_quit_pressed():
	get_tree().quit()

func _take_rock():
	player.rocks += 1
	pick_up.visible = false
	rock.queue_free()

func _on_rock_entered():
	pick_up.visible = true

func _on_rock_exited():
	pick_up.visible = false
