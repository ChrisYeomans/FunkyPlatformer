extends Node2D
class_name PlayerMovement

@export var player: Player
@export var right_foot_ray: RayCast2D
@export var right_step_ray: RayCast2D
@export var left_foot_ray: RayCast2D
@export var left_step_ray: RayCast2D
@export var SPEED = 200.0
@export var JUMP_VELOCITY = -300.0
@export var coyote_time = 0.2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var floor_touch: int
var direction: int = 1
var collider

# Called when the node enters the scene tree for the first time.
func _ready():
	player.set_floor_snap_length(10.0) 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if player.velocity.x == 0 and player.animated_sprite.animation != "basic_attack":
		player.animated_sprite.play("idle")
	
	handle_jump(delta)
	handle_move_left_right()
	handle_step_up()

	player.move_and_slide()

func handle_step_up():
	if player.is_on_floor():
		if right_foot_ray.is_colliding() and !right_step_ray.is_colliding():
			player.position.y -= right_step_ray.position.y
			player.position.x -= right_step_ray.position.x
		if left_foot_ray.is_colliding() and !left_step_ray.is_colliding():
			player.position.y -= left_step_ray.position.y
			player.position.x -= left_step_ray.position.x

func handle_move_left_right():
	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_axis("ui_left", "ui_right")
	
	if direction == -1:
		player.animated_sprite.play("left")
	if direction == 1:
		player.animated_sprite.play("right")
		
	if direction:
		player.velocity.x = direction * SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)

func handle_jump(delta):
	# Add the gravity.
	if not player.is_on_floor():
		player.velocity.y += gravity * delta
	else:
		floor_touch = Time.get_ticks_msec()

	# Handle jump.
	if can_jump():
		floor_touch = 0
		player.velocity.y = JUMP_VELOCITY

func can_jump():
	return Input.is_action_just_pressed("ui_accept") \
	and (player.is_on_floor() or (Time.get_ticks_msec() - floor_touch) < coyote_time*1000)

