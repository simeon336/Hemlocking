extends Area2D
@onready var hole2 = $"."
signal entered2

# Called when the node enters the scene tree for the first time.
func _ready():
	hole2.body_entered.connect(_on_body_entered)


func _on_body_entered(body):
	emit_signal("entered2")
