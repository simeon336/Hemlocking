extends Area2D
signal winscreen
@onready var win_hole = $"."


func _ready():
	win_hole.body_entered.connect(_win_screen)

func _win_screen(body):
	emit_signal("winscreen")
	print("emitet")
