extends CharacterBody2D

# Player properties
var max_hp : int = 100
var hp : int = max_hp
var defense : int = 10
var attack : int = 20

# Speed
var speed : int = 200

# Declare member variables here. Examples:

var velocity: Vector2 = Vector2()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Input handling
	var input_direction: Vector2 = Vector2()

	if Input.is_action_pressed("ui_right"):
		input_direction.x += 1
	if Input.is_action_pressed("ui_left"):
		input_direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		input_direction.y += 1
	if Input.is_action_pressed("ui_up"):
		input_direction.y -= 1

	# Normalize the input direction to ensure consistent movement speed in all directions
	input_direction = input_direction.normalized()

	# Calculate the player's velocity based on input and speed
	velocity = input_direction * speed

	# Move the player using move_and_slide
	velocity = move_and_slide(velocity)

func take_damage(damage: int):
	var final_damage = max(damage - defense, 0)
	hp -= final_damage

	print("Player took damage:", final_damage)
	print_stats()

	if hp <= 0:
		hp = 0
		# Implement game over logic or respawn logic here

# Handle healing the player
func heal(amount: int):
	hp = min(hp + amount, max_hp)

func eat(amount: int):
	defense = defense + amount
# Function to print health
func print_stats():
	print("Hp: ", hp, "/", max_hp)
	print("Defense: ", defense)
	print("Attack :", attack)

# Called every time the node receives an input event (mouse, keyboard, joystick, etc.)
func _on_button_pressed():
	take_damage(20)
	print_stats()


func _on_heal_pressed():
	heal(10)
	print_stats()


func _on_seed_pressed():
	eat(5)
	print_stats()
