extends CharacterBody2D

signal mash_requested

const _MOVEMENT_SPEED := 400.0
const _FLOOR_DAMPENING_SPEED := 100.0
const _AIR_DAMPENING_SPEED := 10.0
const _JUMP_VELOCITY := -600.0
const _SMALL_JUMP_VELOCITY := -200.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var _gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var _mash_available = false

@onready var _instructions : Label = $PressLabel
@onready var _frog_sprite : Sprite2D = $Frog


func _physics_process(delta) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += _gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = _JUMP_VELOCITY
		$BigJumpSound.play()
	
	if _mash_available and Input.is_action_just_pressed("mash"):
		mash_requested.emit()

	# Handle movement
	var direction := Input.get_axis("move_left", "move_right")
	var velocity_near_zero = velocity.x > -.5 and velocity.x < .5
	if direction and velocity_near_zero:
		velocity.x = direction * _MOVEMENT_SPEED
		if is_on_floor():
			velocity.y = _SMALL_JUMP_VELOCITY
			$SmallJumpSound.play()
	elif is_on_floor():
		velocity.x = move_toward(velocity.x, 0, _FLOOR_DAMPENING_SPEED)
	else:
		velocity.x = move_toward(velocity.x, 0, _AIR_DAMPENING_SPEED)

	# Determine facing direction
	if velocity.x < 0:
		_frog_sprite.scale.x = 1
	elif velocity.x > 0:
		_frog_sprite.scale.x = -1

	# Determine what sprite frame the frog should be
	if is_on_floor():
		_frog_sprite.frame = 0
	elif velocity.y > 20 or velocity.y < -20:
		_frog_sprite.frame = 2

	move_and_slide()


func _on_touch_area_area_entered(_area) -> void:
	_instructions.show()
	_mash_available = true


func _on_touch_area_area_exited(_area) -> void:
	_instructions.hide()
	_mash_available = false
