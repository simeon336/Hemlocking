extends Node2D

var players: Array = []
var enemies: Array = []
var currentTurn: int = 0

func _ready():
	players = $PlayerGroup.get_children()
	enemies = $EnemyGroup.get_children()
	_start_player_turn()
	$EnemyGroup.attacked.connect(_on_enemy_attacked)
	
func _on_enemy_attacked():
	_start_player_turn()
	
func _start_player_turn():
	players[currentTurn].focus()

func _end_player_turn():
	players[currentTurn].unfocus()
	currentTurn += 1
	print("1")
	if currentTurn >= players.size():
		currentTurn = 0
		_start_enemy_turn()
	else:
		_start_player_turn()

func _start_enemy_turn():

	for player in players:
		var targetPlayer = players[currentTurn]
		targetPlayer.take_damage(10)
		print("Enemy dealt damage to player. Player health:", targetPlayer.health)
	_end_enemy_turn()

func _end_enemy_turn():
	# Implement post-enemy-turn logic
	pass
