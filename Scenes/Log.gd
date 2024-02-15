extends Area2D

@onready var log = $"."
signal entered
signal exited

func _ready():
	log.body_entered.connect(_on_body_entered)
	log.body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	emit_signal("entered")
	
func _on_body_exited(body):
	emit_signal("exited")
