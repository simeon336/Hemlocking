extends ProgressBar

@onready var player = $"../Player"


func _ready():
	player.health_changed.connect(_on_player_health_changed)

func _on_player_health_changed():
	update()

func update():
	value = player.hp * 100 / player.max_hp

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
