extends Area2D

var max_hp : int = 100
var hp : int = max_hp
var defense : int = 10
var attack : int = 20
var poisoned : bool = false

func take_damage(damage: int):
	var final_damage = max(damage - defense, 0)
	hp -= final_damage

	print("Player took damage:", final_damage)
	print_stats()

	if hp <= 0:
		hp = 0
	
		
func print_stats():
	print("Hp: ", hp, "/", max_hp)
	print("Defense: ", defense)
	print("Attack :", attack)
	
func takeDamage(damage:int):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Connect the signal to the function in the _ready() function
func _ready():
	# Replace "Enemy" with the name of your enemy scene
	pass


func _on_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene_to_file("res://Scenes/combat.tscn")
		print("Entered")
