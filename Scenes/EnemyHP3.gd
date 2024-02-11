extends ProgressBar

@onready var enemy3 = $"../Enemy3"


func _ready():
	enemy3.enemy3_hp_changed.connect(_on_health_changed)
	update()

func _on_health_changed():
	update()

func update():
	value = enemy3.hp * 100 / enemy3.max_hp

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
