extends CharacterBody2D

signal mash_requested

const _MOVEMENT_SPEED := 400.0
const _DAMPENING_SPEED := 10.0
const _JUMP_VELOCITY := -600.0
const _MOVE_Y_VELOCITY := -200.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var _gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var _mash_available = false

@onready var _instructions : Label = $PressLabel
@onready var _frog_sprite : Sprite2D = $Frog


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += _gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = _JUMP_VELOCITY
	
	if _mash_available and Input.is_action_just_pressed("mash"):
		mash_requested.emit()

	var direction := Input.get_axis("move_left", "move_right")
	var velocity_near_zero = velocity.x > -.5 and velocity.x < .5
	if direction and velocity_near_zero:
		velocity.x = direction * _MOVEMENT_SPEED
		if is_on_floor():
			velocity.y = _MOVE_Y_VELOCITY
	elif is_on_floor():
		velocity.x = move_toward(velocity.x, 0, _DAMPENING_SPEED)
#	elif direction and velocity.y <0: # Frog is in air:
#		velocity.x = move_toward(velocity.x, 0, _DAMPENING_SPEED)

	if velocity.x < 0:
		_frog_sprite.scale.x = 1
	elif velocity.x > 0:
		_frog_sprite.scale.x = -1


	move_and_slide()



func _on_touch_area_body_entered(body) -> void:
	if is_instance_of(body, FrogBaby):
		_instructions.show()
		_mash_available = true


func _on_touch_area_body_exited(body) -> void:
	if is_instance_of(body, FrogBaby):
		_instructions.hide()
		_mash_available = false
