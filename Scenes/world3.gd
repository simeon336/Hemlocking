extends Node2D

@onready var pause_menu = $Player/Camera2D/PauseMenu
@onready var enemy3 = $Enemy3
@onready var player = $Player
@onready var rock = $Rock
@onready var pick_up = $PickUp
@onready var plant = $Plant
@onready var harvestButton = $Harvest
@onready var teleport = $Teleport
@onready var tpButton = $TpButton


var current_enemy : Node2D = null

func _ready():

	player.position.x = 120
	player.position.y = 125
	pause_menu.resume.connect(_on_resume_pressed)
	pause_menu.quit.connect(_on_quit_pressed)
	pause_menu.potion.connect(_on_potion_pressed)
	pause_menu.seed.connect(_on_seed_pressed)
	pause_menu.stem.connect(_on_stem_pressed)
	rock.entered.connect(_on_rock_entered)
	rock.exited.connect(_on_rock_exited)
	pick_up.pressed.connect(_take_rock)
	harvestButton.pressed.connect(_harvest)
	plant.start_harvest.connect(_show_harvest)
	plant.stop_harvest.connect(_hide_harvest)
	teleport.entered.connect(_show_tp)
	teleport.exited.connect(_hide_tp)
	tpButton.pressed.connect(_tp_pressed)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		set_is_paused(true)
		
	if enemy3 != null:
		if enemy3.hp <= 0:
			player.blood_vials += 2
			enemy3.queue_free()
			
func _show_harvest():
	if player.blood_vials > 0:
		harvestButton.visible = true

func _hide_harvest():
	harvestButton.visible = false

func _show_tp():
	if enemy3 == null:
		tpButton.visible = true
	
func _hide_tp():
	tpButton.visible = false

func _tp_pressed():
	player.position.x = 579
	player.position.y = -150

func _harvest():
	player.stems += 2
	player.seeds += 3
	player.potions += 1
	harvestButton.visible = false
	player.blood_vials -= 1
	plant.queue_free()

func _take_rock():
	player.rocks += 1
	pick_up.visible = false
	rock.queue_free()

func _on_rock_entered():
	pick_up.visible = true

func _on_rock_exited():
	pick_up.visible = false

func _on_potion_pressed():
	player.heal(50)
	player.potions -= 1
	player.print_stats()


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

