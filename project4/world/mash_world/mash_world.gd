extends Node2D

const _MASH_VALUE := 2
const _ARM_MOVEMENT := 20
const _NOSE_GRAVITY := 2

var _arm_direction := 1
var _mash_allowed := true
var _nose_velocity := -25

@onready var _rub_label : Label = $RubLabel
@onready var _nose : Sprite2D = $BabyNose


func _ready() -> void:
	_set_rub_label()


func _process(delta) -> void:
	if _mash_allowed and Input.is_action_just_pressed("mash"):
		ScoreKeeper.percent_rubbed += _MASH_VALUE
		$FrogArm.global_position.x += _ARM_MOVEMENT * _arm_direction
		_arm_direction *= -1
		_set_rub_label()
		if ScoreKeeper.percent_rubbed >= 100:
			_mash_allowed = false
			_rub_label.text = "Nose gone!"
			$LeaveSceneTimer.stop()
			$EndGameTimer.start()

	if !_mash_allowed:
		_nose.rotate(4*TAU*delta)
		var nose_movement := Vector2(-3, _nose_velocity)
		_nose.global_translate(nose_movement)
		_nose_velocity += _NOSE_GRAVITY



func _set_rub_label() -> void:
	_rub_label.text = "Percent Rubbed: %d%%" % ScoreKeeper.percent_rubbed


func _on_leave_scene_timer_timeout() -> void:
	var tween := create_tween()
	tween.tween_property($Music, "volume_db", -5, .5)
	tween.tween_callback(_leave_scene)


func _leave_scene() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://world/world.tscn")


func _on_end_game_timer_timeout() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://ui/end_screen.tscn")
