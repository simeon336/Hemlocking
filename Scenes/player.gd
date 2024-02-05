extends CharacterBody2D

signal health_changed(max_hp : int, hp : int)

# Player properties
var max_hp : int = 10033
var hp : int = max_hp
var defense : int = 0
var attack : int = 20
var hasDatura : bool = false
var is_in_combat : bool = false
var toxicity : float = 0
# Speed
@onready var player = $"."

@export var speed : int = 200
func _ready():
	load_game()
	
# Called every frame
func _process(delta):
	if(hp <= 0):
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
		
	if(get_tree().current_scene.name != "World"):
		return
	
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

	
	
func eat_datura():
	hasDatura = false
	attack += 5
	save_game()
	
# Handle damage to the player
func take_damage(damage: int):
	var final_damage = max(damage - defense, 0)
	hp -= final_damage
	print("Player took damage:", final_damage)
	print_stats()
	save_game()
	health_changed.emit(max_hp, hp)

	if hp <= 0:
		hp = 0
	emit_signal("health_changed")

# Handle healing the player
func heal(amount: int):
	hp = min(hp + amount, max_hp)
	save_game()
	emit_signal("health_changed")
	
func eat_seed(amount: int):
	defense = defense + amount
	save_game()
# Function to print health
func print_stats():
	print("Hp: ", hp, "/", max_hp)
	print("Defense: ", defense)
	print("Attack :", attack)

func eat_stem():
	toxicity += 3.36
	heal(20)

func save():
	var save_data = {
		"max_hp": max_hp,
		"hp": hp,
		"defense": defense,
		"attack": attack,
		"hasDatura": hasDatura,
		"is_in_combat": is_in_combat,
		"toxicity": toxicity
	}
	return save_data

func save_game():
	var save_game = FileAccess.open("res://Scenes/savegame.json", FileAccess.WRITE)
	var node = get_node(".")
	var node_data = node.call("save")
	var json_string = JSON.stringify(node_data)
	save_game.store_line(json_string)
	
func load_game():
	if not FileAccess.file_exists("res://Scenes/savegame.json"):
		return # Error! We don't have a save to load.
	get_node(".").print_stats()
	var save_game = FileAccess.open("res://Scenes/savegame.json", FileAccess.READ)
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()

		# Creates the helper class to interact with JSON
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object
		var node_data = json.get_data()
		
		player.max_hp = node_data["max_hp"]
		player.hp = node_data["hp"]
		player.defense = node_data["defense"]
		player.attack = node_data["attack"]
		player.hasDatura = node_data["hasDatura"]
		player.is_in_combat = node_data["is_in_combat"]
		player.toxicity = node_data["toxicity"]
		# Firstly, we need to create the object and add it to the tree and set its position.

