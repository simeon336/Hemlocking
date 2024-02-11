extends ProgressBar

@onready var enemy4 = $"../Enemy4"


func _ready():
	enemy4.enemy4_hp_changed.connect(_on_health_changed)
	update()

func _on_health_changed():
	update()

func update():
	value = enemy4.hp * 100 / enemy4.max_hp

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
