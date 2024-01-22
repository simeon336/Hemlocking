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
