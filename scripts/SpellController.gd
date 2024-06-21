extends Node2D
class_name SpellController

enum ELEMENTAL_TYPES {Wood, Fire, Earth, Metal, Water}
enum SHAPE {None, Rectangle, Circular}
enum EFFECTS {None, Explosion, Mist}
enum PATH {None, Straight, DiagDown}

var elemental_power: Array[int] = [0, 0, 0, 0, 0]
var range: Array[float] = [0.0, 0.0, 0.0, 0.0, 0.0]
var persistence_time: Array[float] = [0.0, 0.0, 0.0, 0.0, 0.0] # seconds
var shape: SHAPE = SHAPE.None
var shape_scale: Array[float] = [1.0, 1.0, 1.0, 1.0, 1.0]
var path: PATH = PATH.None
var elemental_effects: Array[EFFECTS] = [EFFECTS.None, EFFECTS.None, EFFECTS.None, EFFECTS.None, EFFECTS.None]

@onready var sprite_2d = $Area2D/Sprite2D

var direction: int

# Called when the node enters the scene tree for the first time.
func _ready():
	if direction == -1:
		sprite_2d.flip_h = true

func _physics_process(delta):
	match path:
		PATH.DiagDown:
			diag_down(delta)
		PATH.Straight:
			straight(delta)
		
func speed():
	var total = 0 
	for e in elemental_power:
		total += e
	return total*100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func initialize(dirn):
	direction = dirn
	elemental_power[0] = 1
	elemental_power[1] = 1
	path = PATH.DiagDown

func _on_area_2d_body_entered(body):
	if body is TileMap:
		queue_free()
	elif body is Mob:
		body.queue_free()
		queue_free()
	else:
		print(body)

func diag_down(delta): 
	position += transform.x * speed() * delta * direction
	position += transform.y * speed()/2 * delta

func straight(delta): 
	position += transform.x * speed() * delta * direction
