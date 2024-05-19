extends CharacterBody2D


@export var SPEED = 300.0
@export var start_position_node: Node2D
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$AnimatedSprite2D.play("idle")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction == -1:
		$AnimatedSprite2D.play("left")
	if direction == 1:
		$AnimatedSprite2D.play("right")
	
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func reset_player_to_start():
	position.x = start_position_node.position.x
	position.y = start_position_node.position.y
	
func kill_player():
	print("Player Killed")
	reset_player_to_start()
	
func player_win():
	print("Player Wins")
	reset_player_to_start()
