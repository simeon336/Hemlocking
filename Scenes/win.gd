extends Area2D
@onready var hole = $"."


# Called when the node enters the scene tree for the first time.
func _ready():
	hole.body_entered.connect(_on_body_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	get_tree().change_scene_to_file("res://Scenes/WinScreen.tscn")
