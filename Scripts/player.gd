extends CharacterBody2D

@export var speed: int = 35

func handle_input():
	var move_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = move_direction*speed

func _physics_process(delta):
	handle_input()
	move_and_slide()
