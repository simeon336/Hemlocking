extends Area2D

@onready var hole = $"."

func _ready():
	hole.body_entered.connect(_on_body_entered)

func _process(delta):
	pass

func _on_body_entered(body):
	get_tree().change_scene_to_file("res://Scenes/world2.tscn")
