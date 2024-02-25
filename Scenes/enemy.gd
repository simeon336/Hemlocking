extends Area2D
@onready var enemy = $"."
signal enemy_hp_changed
@export var max_hp : int 
@export var hp : int 
@export var defense : int
@export var attack : int 
@export var level_num : int 
var file_path = "user://enemydata.save"

func _ready():
	load_game()
	enemy.body_entered.connect(_on_body_entered)

func take_damage(damage: int):
	var final_damage = max(damage - defense, 0)
	hp -= final_damage
	emit_signal("enemy_hp_changed")
	if hp <= 0:
		var dir = DirAccess.open("user://")
		if dir != null:
			dir.remove("enemydata.save")
			print("removed")
		else:
			print("error removing")
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
	save_game()
	get_tree().change_scene_to_file("res://Scenes/battle_arena.tscn")

func save_game():
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	if file != null: 
		file.store_var(max_hp)
		file.store_var(hp)
		file.store_var(defense)
		file.store_var(attack)
		file.store_var(level_num)
	else:
		print("Error saving file enemy")
	
func load_game():
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file != null:
		max_hp = file.get_var(max_hp)
		hp = file.get_var(hp)
		defense = file.get_var(defense)
		attack = file.get_var(attack)
		level_num = file.get_var(level_num)
	else:
		print("Error loading file enemy")
