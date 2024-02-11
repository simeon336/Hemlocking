extends Area2D
signal entered
signal exited
@onready var rock = $"."

# Called when the node enters the scene tree for the first time.
func _ready():
	rock.body_entered.connect(_on_body_entered)
	rock.body_exited.connect(_on_body_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	emit_signal("entered")
	
func _on_body_exited(body):
	emit_signal("exited")
