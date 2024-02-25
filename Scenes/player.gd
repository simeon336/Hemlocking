extends CharacterBody2D

signal health_changed
var save_path = "user://playerdata.save"
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
	save_game()
	
func take_damage(damage: int):
	var final_damage = max(damage - defense, 0)
	hp -= final_damage
	emit_signal("health_changed")

	if hp < 0:
		hp = 0
	emit_signal("health_changed")
	save_game()
	
func heal(amount: int):
	hp = min(hp + amount, max_hp)
	emit_signal("health_changed")
	save_game()
	
func eat_seed():
	defense += 5
	seeds -= 1
	if seeds < 0:
		seeds = 0
	save_game()

func print_stats():
	print("Hp: ", hp, "/", max_hp)
	print("Defense: ", defense)
	print("Attack :", attack)

func eat_stem():
	toxicity += 5
	heal(30)
	stems -= 1
	if stems < 0:
		stems = 0
	save_game()

func save_game():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	if file != null:
		file.store_var(max_hp)
		file.store_var(hp)
		file.store_var(defense)
		file.store_var(attack)
		file.store_var(is_in_combat)
		file.store_var(toxicity)
		file.store_var(seeds)
		file.store_var(stems)
		file.store_var(potions)
		file.store_var(blood_vials)
		file.store_var(rocks)
	else:
		print("Error saving file player")
	
func load_game():
	var file = FileAccess.open(save_path, FileAccess.READ)
	if file != null:
		max_hp = file.get_var(max_hp)
		hp = file.get_var(hp)
		defense = file.get_var(defense)
		attack = file.get_var(attack)
		is_in_combat = file.get_var(is_in_combat)
		toxicity = file.get_var(toxicity)
		seeds = file.get_var(seeds)
		stems = file.get_var(stems)
		potions = file.get_var(potions)
		blood_vials = file.get_var(blood_vials)
		rocks = file.get_var(rocks)
	else:
		print("no data loaded player")
