extends Node2D

@onready var player = $Player
@onready var attackButton = $AttackButton
@onready var enemy = $Enemy
@onready var itemButton = $Items
@onready var potionButton = $Potion
@onready var defendButton = $Defend
@onready var seedButton = $Seed
@onready var daturaButton = $Datura
@onready var hemlockButton = $Hemlock

var is_player_turn : bool = true
func _ready():
	attackButton.pressed.connect(_on_attacked)
	potionButton.pressed.connect(_on_potion_pressed)
	itemButton.pressed.connect(_on_item_pressed)
	defendButton.pressed.connect(_defend)
	seedButton.pressed.connect(_on_seed_pressed)
	daturaButton.pressed.connect(_on_datura_pressed)
	hemlockButton.pressed.connect(_on_hemlock_pressed)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(enemy.hp <= 30):
		_initiate_execution()
	
func _on_item_pressed():
	potionButton.visible = true
	seedButton.visible = true
	hemlockButton.visible = true
	itemButton.visible = false
	attackButton.visible = false
	defendButton.visible = false
	
func _on_potion_pressed():
	player.heal(50)
	hemlockButton.visible = false
	potionButton.visible = false
	seedButton.visible = false
	itemButton.visible = true
	attackButton.visible = true
	defendButton.visible = true	
	_change_turn()
	
func _on_hemlock_pressed():
	player.eat_stem()
	hemlockButton.visible = false
	potionButton.visible = false
	seedButton.visible = false
	itemButton.visible = true
	attackButton.visible = true
	defendButton.visible = true	
	_change_turn()
	
func _on_datura_pressed():
	itemButton.visible = true
	attackButton.visible = true
	defendButton.visible = true	
	enemy.take_damage(enemy.max_hp)
	player.eat_datura()	

func _initiate_execution():
	daturaButton.visible = true
	potionButton.visible = false
	seedButton.visible = false
	itemButton.visible = false
	attackButton.visible = false
	defendButton.visible = false
	hemlockButton.visible = false
func _defend():
	player.take_damage(enemy.attack/2)
	
func _on_seed_pressed():
	player.eat_seed(5)
	_change_turn()
	potionButton.visible = false
	seedButton.visible = false
	itemButton.visible = true
	attackButton.visible = true
	defendButton.visible = true	
	
func _on_attacked():
	enemy.poison_tick(player.toxicity)
	enemy.take_damage(player.attack)
	_change_turn()

func _enemy_turn():
	await get_tree().create_timer(1).timeout
	player.take_damage(enemy.attack)
	_change_turn()
	
func _change_turn():
	is_player_turn = not is_player_turn
	if(is_player_turn):
		attackButton.visible = true
	else:
		attackButton.visible = false
		_enemy_turn()
