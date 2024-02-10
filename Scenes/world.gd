extends Node2D

@onready var pause_menu = $Player/Camera2D/PauseMenu
@onready var enemy = $Enemy
@onready var player = $Player
@onready var main_menu = $MainMenu
@onready var enemy2 = $Enemy2

var current_enemy : Node2D = null
# Called when the node enters the scene tree for the first time.
func _ready():
	pause_menu.resume.connect(_on_resume_pressed)
	pause_menu.quit.connect(_on_quit_pressed)
	pause_menu.potion.connect(_on_potion_pressed)
	pause_menu.seed.connect(_on_seed_pressed)
	pause_menu.stem.connect(_on_stem_pressed)
	if turns.enemy_num == 1:
		current_enemy = enemy
	if turns.enemy_num == 2:
		current_enemy = enemy2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		set_is_paused(true)
		
	if current_enemy != null:
		if current_enemy.hp <= 0:
			current_enemy.queue_free()

func _on_potion_pressed():
	player.heal(50)
	player.potion -= 1
	player.print_stats()


func _on_seed_pressed():
	player.eat_seed(5)
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

