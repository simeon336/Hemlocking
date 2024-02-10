extends ProgressBar

@onready var enemy = $"../Enemy"


func _ready():
	if enemy:
		enemy.enemy_hp_changed.connect(_on_player_health_changed)
		update()

func _on_player_health_changed():
	update()

func update():
	value = enemy.hp * 100 / enemy.max_hp

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
