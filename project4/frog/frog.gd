extends CharacterBody2D

signal mash_requested

const _MOVEMENT_SPEED := 300.0
const _DAMPENING_SPEED := 10
const _JUMP_VELOCITY := -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var _gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var _mash_available = false

@onready var _instructions : Label = $PressLabel


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

	if direction and velocity.x==0:
		velocity.x = direction * _MOVEMENT_SPEED
	elif is_on_floor():
		velocity.x = move_toward(velocity.x, 0, _DAMPENING_SPEED)
	if velocity.x < 0:
		$Frog.scale.x = 1
		print("left: %d" %scale.x)
	elif velocity.x > 0:
		$Frog.scale.x = -1
		print("right: %d" %scale.x)
	move_and_slide()
	print("before: %d" %scale.x)



func _on_touch_area_body_entered(body) -> void:
	if is_instance_of(body, FrogBaby):
		_instructions.show()
		_mash_available = true


func _on_touch_area_body_exited(body) -> void:
	if is_instance_of(body, FrogBaby):
		_instructions.hide()
		_mash_available = false
