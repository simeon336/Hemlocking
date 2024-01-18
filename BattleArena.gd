extends Node2D

@onready var player = $Player
@onready var attackButton = $AttackButton
@onready var enemy = $Enemy
@onready var itemButton = $Items
@onready var potionButton = $Potion

var is_player_turn : bool = true
func _ready():
	attackButton.pressed.connect(_on_attacked)
	potionButton.pressed.connect(_on_potion_pressed)
	itemButton.pressed.connect(_on_item_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_item_pressed():
	potionButton.visible = true
	itemButton.visible = false
	attackButton.visible = false
	
func _on_potion_pressed():
	player.heal(50)
	potionButton.visible = false
	itemButton.visible = true
	attackButton.visible = true
	

func _on_attacked():
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
