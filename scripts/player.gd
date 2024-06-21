extends CharacterBody2D
class_name Player

@export var start_position_node: Node2D
@export var spell_controller: PackedScene
@onready var animated_sprite = $AnimatedSprite2D
@onready var spell_origin = $SpellOrigin
@onready var player_movement = $PlayerMovement

var last_pressed_direction: int = 1

func _ready():
	pass

func _physics_process(delta):
	pass
	
func _process(delta):
	if Input.is_action_just_pressed("ui_left"):
		last_pressed_direction = -1
	elif Input.is_action_just_pressed("ui_right"):
		last_pressed_direction = 1
		
	if Input.is_action_pressed("attack"):
		animated_sprite.play("basic_attack")
	
	if Input.is_action_just_pressed("fire_spell"):
		fire_spell()

func fire_spell():
	var p = spell_controller.instantiate() as SpellController
	p.initialize(last_pressed_direction)
	owner.add_child(p)
	p.transform = spell_origin.global_transform
	
func reset_player_to_start():
	position.x = start_position_node.position.x
	position.y = start_position_node.position.y
	
func kill_player():
	print("Player Killed")
	reset_player_to_start()
	
func player_win():
	print("Player Wins")
	reset_player_to_start()



