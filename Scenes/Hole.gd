extends Area2D
@onready var hole = $"."
signal entered
func _ready():
	hole.body_entered.connect(_on_body_entered)

func _process(delta):
	pass

func _on_body_entered(body):
		emit_signal("entered")

