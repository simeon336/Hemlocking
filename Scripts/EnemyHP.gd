extends ProgressBar

@onready var enemy2 = $"../Enemy2"


func _ready():
	enemy2.enemy2_hp_changed.connect(_on_health_changed)
	update()

func _on_health_changed():
	update()

func update():
	value = enemy2.hp * 100 / enemy2.max_hp

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
