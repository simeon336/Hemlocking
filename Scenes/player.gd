extends CharacterBody2D

signal health_changed(max_hp : int, hp : int)

# Player properties
var max_hp : int = 100
var hp : int = max_hp
var defense : int = 10
var attack : int = 20
var hasDatura : bool = false
# Speed
@export var speed : int = 200
func _ready():
	pass
# Called every frame
func _process(delta):
	# Player movement
	var velocity = Vector2()

	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.animation = "idle"

	velocity = velocity.normalized() * speed
	velocity *= delta  # Scale velocity by delta for consistent movement
	
	if velocity.x != 0 || velocity.y != 0:
		$AnimatedSprite2D.animation = "run"
		$AnimatedSprite2D.flip_h = velocity.x < 0
	else:
		$AnimatedSprite2D.animation = "idle"
	# Use move_and_collide to handle collisions
	var collision = move_and_collide(velocity)

	if collision:
		# If there is a collision, adjust the position and handle any other logic
		position += collision.get_remainder()
	else:
		# If no collision, simply update the position
		position += velocity

	print("Position:", position)
	
func eat_datura():
	hasDatura = true
	

# Handle damage to the player
func take_damage(damage: int):
	var final_damage = max(damage - defense, 0)
	hp -= final_damage

	print("Player took damage:", final_damage)
	print_stats()
	health_changed.emit(max_hp, hp)

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


func _on_eat_a_root__pressed():
	attack = attack + 5
	defense = defense + 5
	heal(20)



