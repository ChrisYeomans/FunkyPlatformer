extends CharacterBody2D

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@export var SPEED = 60.0
const JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1

func _ready():
	$AnimatedSprite2D.play("idle")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if ray_cast_right.is_colliding() and ray_cast_right.get_collider().name != "Player":
		direction = -1
	if ray_cast_left.is_colliding() and ray_cast_left.get_collider().name != "Player":
		direction = 1

	velocity.x = direction * SPEED

	move_and_slide()
