extends Area2D
@onready var plant = $"."

signal start_harvest
signal stop_harvest
# Called when the node enters the scene tree for the first time.
func _ready():
	plant.body_entered.connect(_on_body_entered)
	plant.body_exited.connect(_on_body_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	emit_signal("start_harvest")

func _on_body_exited(body):
	emit_signal("stop_harvest")
