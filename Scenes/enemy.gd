extends Area2D
@onready var enemy = $"."
signal enemy_hp_changed
@export var max_hp : int = 100
@export var hp : int = max_hp
@export var defense : int = 0
@export var attack : int = 10


func _ready():
	load_game()
	enemy.body_entered.connect(_on_body_entered)

func take_damage(damage: int):
	var final_damage = max(damage - defense, 0)
	hp -= final_damage
	emit_signal("enemy_hp_changed")
	save_game()
		
func print_stats():
	print("Hp: ", hp, "/", max_hp)
	print("Defense: ", defense)
	print("Attack :", attack)
 
func poison_tick(amount: float):
	hp -= amount
	emit_signal("enemy_hp_changed")
	save_game()

func _on_body_entered(body):
	turns.enemy_num = 1
	save_game()
	get_tree().change_scene_to_file("res://Scenes/battle_arena.tscn")

func save():
	var save_data = {
		"max_hp": max_hp,
		"hp": hp,
		"defense": defense,
		"attack": attack
	}
	return save_data


func save_game():
	var save_file = FileAccess.open("res://SaveFiles/enemysave.json", FileAccess.WRITE)
	if save_file != null:
		var node = get_node(".")
		var node_data = node.call("save")
		var json_string = JSON.stringify(node_data)
		save_file.store_line(json_string)
		save_file.close()
	else:
		print("Failed to open save file.")
		
	
func load_game():
	if not FileAccess.file_exists("res://SaveFiles/enemysave.json"):
		return  

	var save_game = FileAccess.open("res://SaveFiles/enemysave.json", FileAccess.READ)
	
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()
		var json = JSON.new()

		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		var node_data = json.get_data()
		

		max_hp = node_data["max_hp"]
		hp = node_data["hp"]
		defense = node_data["defense"]
		attack = node_data["attack"]
		
	save_game.close()
