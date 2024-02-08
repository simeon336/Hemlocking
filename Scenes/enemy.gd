extends Area2D
@onready var enemy = $"."
signal enemy_hp_changed
var max_hp : int = 100
var hp : int = max_hp
var defense : int = 3
var attack : int = 20
var poison : float = 0
signal enemy_died

func _ready():
	pass


func take_damage(damage: int):
	var final_damage = max(damage - defense, 0)
	hp -= final_damage
	print("Player took damage:", final_damage)
	print_stats()

	if hp <= 0:
		hp = 0
		emit_signal("enemy_died")
		save_game()
		get_tree().change_scene_to_file("res://Scenes/world.tscn")
				
	emit_signal("enemy_hp_changed")
		
func print_stats():
	print("Hp: ", hp, "/", max_hp)
	print("Defense: ", defense)
	print("Attack :", attack)
 
func poison_tick(amount: float):
	poison += amount
	take_damage(poison)
	

func _on_body_entered(body):
	get_tree().change_scene_to_file("res://Scenes/battle_arena.tscn")

func save():
	var position_array = [position.x, position.y]
	var save_data = {
		"max_hp": max_hp,
		"hp": hp,
		"defense": defense,
		"attack": attack,
		"poison": poison,
		"position": position_array  # Convert Vector2 to array
	}
	return save_data


func save_game():
	var save_game = FileAccess.open("res://SaveFiles/enemysave.json", FileAccess.WRITE)
	var node = get_node(".")
	var node_data = node.call("save")
	var json_string = JSON.stringify(node_data)
	save_game.store_line(json_string)
	
func load_game():
	if not FileAccess.file_exists("res://SaveFiles/enemysave.json"):
		return  # Error! We don't have a save to load.

	var save_game = FileAccess.open("res://SaveFiles/enemysave.json", FileAccess.READ)
	
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

		max_hp = node_data["max_hp"]
		hp = node_data["hp"]
		defense = node_data["defense"]
		attack = node_data["attack"]
		poison = node_data["poison"]
		
		save_game.close()
