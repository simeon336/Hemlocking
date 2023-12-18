extends ProgressBar

@onready var player : CharacterBody2D = get_node("res://Scenes/player.tscn")  # Change the path accordingly

func _ready():
	pass

func _on_player_health_changed():
	update()

func update():
	value = player.hp * 100 / player.max_hp

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
