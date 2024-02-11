extends Node2D

@onready var player = $Player
@onready var attackButton = $AttackButton
@onready var itemButton = $Items
@onready var potionButton = $Potion
@onready var defendButton = $Defend
@onready var seedButton = $Seed
@onready var daturaButton = $Datura
@onready var hemlockButton = $Hemlock
@onready var backButton = $Back
@onready var enemy = $Enemy
@onready var enemy2 = $Enemy2
@onready var enemy3 = $Enemy3
@onready var enemy_hp = $EnemyHP
@onready var enemy_hp2 = $EnemyHP2
@onready var enemy_hp3 = $EnemyHP3
@onready var enemy_hp4 = $EnemyHP4
@onready var rockButton = $Rock
@onready var enemy4 = $Enemy4

# Enemy related variables
var current_enemy : Node2D = null
var is_player_turn : bool = true
var original_player_position: Vector2

# Initialization
func _ready():
	connect_signals()
	original_player_position = player.position
	print(original_player_position)
	print(player.position)
	
	if turns.enemy_num == 1:
		enemy_hp.visible = true
		enemy.visible = true
		current_enemy = enemy
		player.position.x = 50
		player.position.y = 60
		
	if turns.enemy_num == 2:
		enemy2.visible = true
		enemy_hp2.visible = true
		current_enemy = enemy2	
		player.position.x = 50
		player.position.y = 60
		
	if turns.enemy_num == 3:
		enemy3.visible = true
		enemy_hp3.visible = true
		current_enemy = enemy3	
		player.position.x = 50
		player.position.y = 60
	
	if turns.enemy_num == 4:
		enemy4.visible = true
		enemy_hp4.visible = true
		current_enemy = enemy4	
		player.position.x = 50
		player.position.y = 60
		
	print(player.position)
		
# Connect signals
func connect_signals():
	attackButton.pressed.connect(_on_attacked)
	potionButton.pressed.connect(_on_potion_pressed)
	itemButton.pressed.connect(_on_item_pressed)
	defendButton.pressed.connect(_defend)
	seedButton.pressed.connect(_on_seed_pressed)
	daturaButton.pressed.connect(_on_datura_pressed)
	hemlockButton.pressed.connect(_on_hemlock_pressed)
	backButton.pressed.connect(_on_back_pressed)
	rockButton.pressed.connect(_on_rock_pressed)


func _process(delta):
	handle_enemy_hp()
	

# Check and execute actions based on enemy's HP
func handle_enemy_hp():
	if current_enemy and current_enemy.hp <= 30:
		_initiate_execution()
	if current_enemy and current_enemy.hp <= 0:
		player.position = original_player_position 
		player.save_game()
		get_tree().change_scene_to_file("res://Scenes/world.tscn")

func _on_rock_pressed():
	current_enemy.take_damage(50)
	player.rocks -= 1
	_change_turn()
	hemlockButton.visible = false
	potionButton.visible = false
	seedButton.visible = false
	itemButton.visible = true
	attackButton.visible = true
	defendButton.visible = true
	rockButton.visible = false
	backButton.visible = false
# Execute actions when items are pressed
func _on_item_pressed():
	potionButton.visible = true
	seedButton.visible = true
	hemlockButton.visible = true
	itemButton.visible = false
	attackButton.visible = false
	defendButton.visible = false
	backButton.visible = true
	rockButton.visible = true
	potionButton.visible = player.potion > 0
	seedButton.visible = player.seeds > 0
	hemlockButton.visible = player.stems > 0
	rockButton.visible = player.rocks > 0
# Go back to main menu
func _on_back_pressed():
	hemlockButton.visible = false
	potionButton.visible = false
	seedButton.visible = false
	itemButton.visible = true
	attackButton.visible = true
	defendButton.visible = true
	backButton.visible = false

# Use potion
func _on_potion_pressed():
	hemlockButton.visible = false
	potionButton.visible = false
	seedButton.visible = false
	itemButton.visible = true
	attackButton.visible = true
	defendButton.visible = true
	rockButton.visible = false
	backButton.visible = false
	player.potion -= 1
	player.heal(50)
	_change_turn()

# Use hemlock
func _on_hemlock_pressed():
	hemlockButton.visible = false
	potionButton.visible = false
	seedButton.visible = false
	itemButton.visible = true
	attackButton.visible = true
	defendButton.visible = true
	rockButton.visible = false
	backButton.visible = false
	player.eat_stem()
	player.stems -= 1
	_change_turn()

# Use datura
func _on_datura_pressed():
	if current_enemy:
		current_enemy.take_damage(current_enemy.max_hp)
	player.position = original_player_position
	print(player.position)
	player.save_game()


# Defend against enemy's attack
func _defend():
	if current_enemy:
		player.take_damage(current_enemy.attack / 2)

# Use seed
func _on_seed_pressed():
	hemlockButton.visible = false
	potionButton.visible = false
	seedButton.visible = false
	itemButton.visible = true
	attackButton.visible = true
	defendButton.visible = true
	rockButton.visible = false
	backButton.visible = false
	player.eat_seed()
	player.seeds -= 1
	_change_turn()

# Attack the enemy
func _on_attacked():
	if current_enemy:
		current_enemy.poison_tick(player.toxicity)
		current_enemy.take_damage(player.attack)
		_change_turn()
	print("bruh")
	print(current_enemy.max_hp)

# Enemy's turn
func _enemy_turn():
	#await get_tree().create_timer(1).timeout
	if current_enemy:
		player.take_damage(current_enemy.attack)
		_change_turn()

# Change turn between player and enemy
func _change_turn():
	is_player_turn = not is_player_turn
	if is_player_turn:
		attackButton.visible = true
	else:
		attackButton.visible = false
		_enemy_turn()

# Initialize execution
func _initiate_execution():
	daturaButton.visible = true
	potionButton.visible = false
	seedButton.visible = false
	itemButton.visible = false
	attackButton.visible = false
	defendButton.visible = false
	hemlockButton.visible = false
