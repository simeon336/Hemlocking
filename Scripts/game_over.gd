extends Node2D
@onready var respawn = $Respawn


# Called when the node enters the scene tree for the first time.
func _ready():
	respawn.pressed.connect(_on_respawn_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_respawn_pressed():
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
