extends CharacterBody2D

signal health_changed(max_hp : int, hp : int)

# Player properties
var max_hp : int = 100
var hp : int = max_hp
var defense : int = 0
var attack : int = 50
var hasDatura : bool = false
var is_in_combat : bool = false
var toxicity : float = 0
var seeds : int = 0
var stems : int = 0
var potion : int = 0
var blood_vials : int = 0
# Speed
@onready var player = $"."

@export var speed : int = 200
func _ready():
	load_game()

# Called every frame
func _process(delta):
	if is_in_combat == true:
		return
	save_game()
	if(hp <= 0):
		hp = max_hp
		save_game()
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
	max_hp += 50
	save_game()
	
	
# Handle damage to the player
func take_damage(damage: int):
	var final_damage = max(damage - defense, 0)
	hp -= final_damage
	print("Player took damage:", final_damage)
	print_stats()
	health_changed.emit(max_hp, hp)

	if hp <= 0:
		hp = 0
	emit_signal("health_changed")
	

# Handle healing the player
func heal(amount: int):
	hp = min(hp + amount, max_hp)
	emit_signal("health_changed")
	save_game()
	
func eat_seed():
	defense += 5
# Function to print health
func print_stats():
	print("Hp: ", hp, "/", max_hp)
	print("Defense: ", defense)
	print("Attack :", attack)

func eat_stem():
	toxicity += 5
	heal(30)

func save():
	var position_array = [position.x, position.y]
	var save_data = {
		"max_hp": max_hp,
		"hp": hp,
		"defense": defense,
		"attack": attack,
		"hasDatura": hasDatura,
		"is_in_combat": is_in_combat,
		"toxicity": toxicity,
		"seeds": seeds,
		"stems": stems,
		"potion": potion,
		"blood_vials": blood_vials,
		"position": position_array  # Convert Vector2 to array
	}
	return save_data



func save_game():
	var save_game = FileAccess.open("res://SaveFiles/playersave.json", FileAccess.WRITE)
	var node = get_node(".")
	var node_data = node.call("save")
	var json_string = JSON.stringify(node_data)
	save_game.store_line(json_string)
	
func load_game():
	if not FileAccess.file_exists("res://SaveFiles/playersave.json"):
		return  # Error! We don't have a save to load.

	var save_game = FileAccess.open("res://SaveFiles/playersave.json", FileAccess.READ)

	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()
		var json = JSON.new()
		
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
			
			
		var node_data = json.get_data()
		
		# Update position if it exists in the saved data
		if "position" in node_data:
			var position_array = node_data["position"]
			position = Vector2(position_array[0], position_array[1])  # Convert array to Vector2

		player.max_hp = node_data["max_hp"]
		player.hp = node_data["hp"]
		player.defense = node_data["defense"]
		player.attack = node_data["attack"]
		player.hasDatura = node_data["hasDatura"]
		player.is_in_combat = node_data["is_in_combat"]
		player.toxicity = node_data["toxicity"]
		player.stems = node_data["stems"]
		player.seeds = node_data["seeds"]
		player.potion = node_data["potion"]
		player.blood_vials = node_data["blood_vials"]
		
		player.print_stats()
		save_game.close()
