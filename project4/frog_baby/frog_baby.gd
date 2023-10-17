class_name FrogBaby
extends CharacterBody2D


const _SPEED := 400.0
const _JUMP_VELOCITY := -500.0
const _ROTATION_PER_SECOND := PI

# Get the gravity from the project settings to be synced with RigidBody nodes.
var _gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var _right := true

@onready var _ball : Sprite2D = $BallSprite
@onready var _baby : Sprite2D = $BabySprite


func _physics_process(delta) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += _gravity * delta

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


func _on_jump_timer_timeout() -> void:
	$JumpSound.play()
	velocity.y = _JUMP_VELOCITY
	var new_time = randf_range(2,5)
	$JumpTimer.set_wait_time(new_time)

