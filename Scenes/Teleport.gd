extends Area2D
signal entered
signal exited
@onready var teleport = $"."

# Called when the node enters the scene tree for the first time.
func _ready():
	teleport.body_entered.connect(_on_body_entered)
	teleport.body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	emit_signal("entered")
	
func _on_body_exited(body):
	emit_signal("exited")
