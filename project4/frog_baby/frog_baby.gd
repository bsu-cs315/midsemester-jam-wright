class_name FrogBaby
extends CharacterBody2D


const _SPEED := 300.0
const _JUMP_VELOCITY := -400.0
const _ROTATION_PER_SECOND := PI

# Get the gravity from the project settings to be synced with RigidBody nodes.
var _gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var _right := true

@onready var _ball : Sprite2D = $BallSprite
@onready var _baby : Sprite2D = $BabySprite

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += _gravity * delta

	# Handle Jump.
#	if Input.is_action_just_pressed("jump") and is_on_floor():
#		velocity.y = _JUMP_VELOCITY
	# Bounce back and forth direction
	if is_on_wall():
		_right = !_right

	if _right:
		velocity.x = _SPEED
		_ball.rotate(_ROTATION_PER_SECOND * delta)
		_baby.scale.x = -1
	else:
		velocity.x = -_SPEED
		_ball.rotate(-_ROTATION_PER_SECOND * delta)
		_baby.scale.x = 1
	
	move_and_slide()
