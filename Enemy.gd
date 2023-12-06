extends Area2D

var max_hp : int = 100
var hp : int = max_hp
var defense : int = 10
var attack : int = 15
var poisonStacks : int = 1

# Speed
var speed : int = 200

func take_damage(damage: int):
	var final_damage = max(damage - defense, 0)
	hp -= final_damage

	print("Enemy took damage:", final_damage)
	print_health()

	if hp <= 0:
		hp = 0


# Handle healing the player
func heal(amount: int):
	hp = min(hp + amount, max_hp)

# Function to print health
func print_health():
	print("Enemy Health:", hp, "/", max_hp)
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_attack_pressed():
	take_damage(25)
	print_health()
	_poison(poisonStacks)

func _poison(stacks: int):
	hp = hp - 2 * poisonStacks
	poisonStacks = poisonStacks + 1 

