extends ProgressBar

var max_hp : int
var hp : int

func _ready():
	load_game()

func _on_player_health_changed():
	update()

func update():
	value = hp * 100 / max_hp

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	load_game()

func load_game():
	if not FileAccess.file_exists("res://SaveFiles/playersave.json"):
		return # Error! We don't have a save to load.
	var save_game = FileAccess.open("res://SaveFiles/playersave.json", FileAccess.READ)
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
		
		max_hp = node_data["max_hp"]
		hp = node_data["hp"]
		update()
