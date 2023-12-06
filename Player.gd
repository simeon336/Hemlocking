extends RigidBody2D

# Player properties
var max_hp : int = 100
var hp : int = max_hp
var defense : int = 10
var attack : int = 20

# Speed
var speed : int = 200

# Called every frame
func _process(delta):
	# Player movement
	var velocity = Vector2()

	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1

	velocity = velocity.normalized() * speed
	linear_velocity = velocity  # Use linear_velocity for RigidBody2D

# Handle damage to the player
func take_damage(damage: int):
	var final_damage = max(damage - defense, 0)
	hp -= final_damage

	if hp <= 0:
		hp = 0
		# Implement game over logic or respawn logic here

# Handle healing the player
func heal(amount: int):
	hp = min(hp + amount, max_hp)

# Function to print health
func print_health():
	print("Player Health:", hp, "/", max_hp)

# Example of using the functions
# Call these functions based on your game logic
# For example, when the player is hit by an enemy, call `take_damage(enemy_attack)`
# When the player picks up a health pack, call `heal(healing_amount)`
# To print the player's health, call `print_health()`

func _on_button_pressed():
	take_damage(10)
	print_health()
