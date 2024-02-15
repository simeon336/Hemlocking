extends CharacterBody2D

signal health_changed(max_hp : int, hp : int)

# Player properties
var max_hp : int = 100
var hp : int = max_hp
var defense : int = 0
var attack : int = 20
var is_in_combat : bool = false
var toxicity : float = 0
var seeds : int = 0
var stems : int = 0
var potions : int = 0
var blood_vials : int = 0
var rocks : int = 0
# Speed
@onready var player = $"."

@export var speed : int = 200
func _ready():
	load_game()

func _process(delta):
	if is_in_combat == true:
		return
	save_game()
	if(hp <= 0):
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
	velocity *= delta  
	
	if velocity.x != 0 || velocity.y != 0:
		$AnimatedSprite2D.animation = "run"
		$AnimatedSprite2D.flip_h = velocity.x < 0
	else:
		$AnimatedSprite2D.animation = "idle"

	var collision = move_and_collide(velocity)

	if collision:
		position += collision.get_remainder()
	else:
		position += velocity
	
func eat_datura():
	attack += 5
	max_hp += 50
	
func take_damage(damage: int):
	var final_damage = max(damage - defense, 0)
	hp -= final_damage
	health_changed.emit(max_hp, hp)

	if hp < 0:
		hp = 0
	emit_signal("health_changed")
	
func heal(amount: int):
	hp = min(hp + amount, max_hp)
	emit_signal("health_changed")
	
func eat_seed():
	defense += 5

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
		"is_in_combat": is_in_combat,
		"toxicity": toxicity,
		"seeds": seeds,
		"stems": stems,
		"potions": potions,
		"blood_vials": blood_vials,
		"rocks": rocks,
		"position": position_array  
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
		return  

	var save_game = FileAccess.open("res://SaveFiles/playersave.json", FileAccess.READ)

	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()
		var json = JSON.new()
		
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue		
			
		var node_data = json.get_data()
		
		if "position" in node_data:
			var position_array = node_data["position"]
			position = Vector2(position_array[0], position_array[1])  

		player.max_hp = node_data["max_hp"]
		player.hp = node_data["hp"]
		player.defense = node_data["defense"]
		player.attack = node_data["attack"]
		player.is_in_combat = node_data["is_in_combat"]
		player.toxicity = node_data["toxicity"]
		player.stems = node_data["stems"]
		player.seeds = node_data["seeds"]
		player.potions = node_data["potions"]
		player.blood_vials = node_data["blood_vials"]
		player.rocks = node_data["rocks"]
		
		save_game.close()
