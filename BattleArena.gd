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
@onready var rockButton = $Rock
@onready var enemy4 = $Enemy4
@onready var datura_info = $daturaInfo
@onready var potion_info = $potionInfo
@onready var seed_info = $seedInfo
@onready var stem_info = $stemInfo
@onready var rock_info = $rockInfo

var current_enemy : Node2D = null
var is_player_turn : bool = true
var original_player_position: Vector2

func _ready():
	connect_signals()
	original_player_position = player.position
	
	if turns.enemy_num == 1:
		enemy.visible = true
		current_enemy = enemy
		player.position.x = 50
		player.position.y = 60
		
	if turns.enemy_num == 2:
		enemy2.visible = true
		current_enemy = enemy2	
		player.position.x = 50
		player.position.y = 60
		
	if turns.enemy_num == 3:
		enemy3.visible = true
		current_enemy = enemy3	
		player.position.x = 50
		player.position.y = 60
	
	if turns.enemy_num == 4:
		enemy4.visible = true
		current_enemy = enemy4	
		player.position.x = 50
		player.position.y = 60
		
func connect_signals():
	attackButton.pressed.connect(_on_attacked)
	potionButton.pressed.connect(_on_potion_pressed)
	potionButton.mouse_entered.connect(_show_potion_info)
	potionButton.mouse_exited.connect(_hide_potion_info)
	itemButton.pressed.connect(_on_item_pressed)
	defendButton.pressed.connect(_defend)
	seedButton.pressed.connect(_on_seed_pressed)
	seedButton.mouse_entered.connect(_show_seed_info)
	seedButton.mouse_exited.connect(_hide_seed_info)
	daturaButton.pressed.connect(_on_datura_pressed)
	daturaButton.mouse_entered.connect(_show_datura_info)
	daturaButton.mouse_exited.connect(_hide_datura_info)
	hemlockButton.pressed.connect(_on_hemlock_pressed)
	hemlockButton.mouse_entered.connect(_show_stem_info)
	hemlockButton.mouse_exited.connect(_hide_stem_info)
	backButton.pressed.connect(_on_back_pressed)
	rockButton.pressed.connect(_on_rock_pressed)
	rockButton.mouse_entered.connect(_show_rock_info)
	rockButton.mouse_exited.connect(_hide_rock_info)


func _process(delta):
	handle_enemy_hp()

func _show_datura_info():
	datura_info.visible = true

func _hide_datura_info():
	datura_info.visible = false

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

func _show_rock_info():
	rock_info.visible = true

func _hide_rock_info():
	rock_info.visible = false
	
func handle_enemy_hp():
	if current_enemy and current_enemy.hp <= 30:
		_initiate_execution()
	if current_enemy and current_enemy.hp <= 0:
		player.position = original_player_position
		player.save_game()
		get_tree().change_scene_to_file("user://Scenes/world.tscn")

func _on_rock_pressed():
	current_enemy.take_damage(50)
	player.rocks -= 1
	if current_enemy:
		current_enemy.poison_tick(player.toxicity)
	_change_turn()
	rock_info.visible = false
	hemlockButton.visible = false
	potionButton.visible = false
	seedButton.visible = false
	itemButton.visible = true
	attackButton.visible = true
	defendButton.visible = true
	rockButton.visible = false
	backButton.visible = false

func _on_item_pressed():
	potionButton.visible = true
	seedButton.visible = true
	hemlockButton.visible = true
	itemButton.visible = false
	attackButton.visible = false
	defendButton.visible = false
	backButton.visible = true
	rockButton.visible = true
	potionButton.visible = player.potions > 0
	seedButton.visible = player.seeds > 0
	hemlockButton.visible = player.stems > 0
	rockButton.visible = player.rocks > 0

func _on_back_pressed():
	hemlockButton.visible = false
	potionButton.visible = false
	seedButton.visible = false
	itemButton.visible = true
	attackButton.visible = true
	defendButton.visible = true
	backButton.visible = false

func _on_potion_pressed():
	potion_info.visible = false
	hemlockButton.visible = false
	potionButton.visible = false
	seedButton.visible = false
	itemButton.visible = true
	attackButton.visible = true
	defendButton.visible = true
	rockButton.visible = false
	backButton.visible = false
	player.potions -= 1
	if current_enemy:
		current_enemy.poison_tick(player.toxicity)
	player.heal(50)
	_change_turn()

func _on_hemlock_pressed():
	stem_info.visible = false
	hemlockButton.visible = false
	potionButton.visible = false
	seedButton.visible = false
	itemButton.visible = true
	attackButton.visible = true
	defendButton.visible = true
	rockButton.visible = false
	backButton.visible = false
	player.eat_stem()
	if current_enemy:
		current_enemy.poison_tick(player.toxicity)
	player.stems -= 1
	_change_turn()

func _on_datura_pressed():
	if current_enemy:
		current_enemy.take_damage(current_enemy.max_hp)
	player.position = original_player_position

func _defend():
	if current_enemy:
		player.take_damage(current_enemy.attack / 2)
		current_enemy.poison_tick(player.toxicity)
		
func _on_seed_pressed():
	seed_info.visible = false
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
	if current_enemy:
		current_enemy.poison_tick(player.toxicity)
	_change_turn()

func _on_attacked():
	if current_enemy:
		current_enemy.poison_tick(player.toxicity)
		current_enemy.take_damage(player.attack)
		_change_turn()

func _enemy_turn():
	await get_tree().create_timer(1).timeout
	if current_enemy:
		player.take_damage(current_enemy.attack)
		_change_turn()

func _change_turn():
	is_player_turn = not is_player_turn
	if is_player_turn:
		attackButton.visible = true
	else:
		attackButton.visible = false
		_enemy_turn()

func _initiate_execution():
	daturaButton.visible = true
	potionButton.visible = false
	seedButton.visible = false
	itemButton.visible = false
	attackButton.visible = false
	defendButton.visible = false
	hemlockButton.visible = false
