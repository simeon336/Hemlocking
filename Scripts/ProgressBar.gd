extends ProgressBar
@onready var progress_bar = $"."

var max_hp : int
var hp : int

func _ready():
	load_game()
	progress_bar.changed.connect(_on_player_health_changed)

func _on_player_health_changed():
	update()

func update():
	value = hp * 100 / max_hp

func _process(delta):
	load_game()

func load_game():
	if not FileAccess.file_exists("user://SaveFiles/playersave.json"):
		return 
	var save_game = FileAccess.open("user://SaveFiles/playersave.json", FileAccess.READ)
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
		update()
	save_game.close()
