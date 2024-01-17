extends Node2D

@onready var player = $Player
@onready var attackButton = $AttackButton
@onready var enemy = $Enemy

func _ready():
	attackButton.pressed.connect(_on_attacked)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_attacked():
	enemy.take_damage(player.attack)
