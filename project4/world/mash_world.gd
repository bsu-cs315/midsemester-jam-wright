extends Node2D

const _MASH_VALUE := 2
const _ARM_MOVEMENT := 20




var _arm_direction := 1
var _mash_allowed := true

@onready var _rub_label : Label = $RubLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	_set_rub_label()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if _mash_allowed and Input.is_action_just_pressed("mash"):
		ScoreKeeper.percent_rubbed += _MASH_VALUE
		$FrogArm.global_position.x += _ARM_MOVEMENT * _arm_direction
		_arm_direction *= -1
		_set_rub_label()
		if ScoreKeeper.percent_rubbed >= 100:
			_mash_allowed = false
			_rub_label.text = "Nose gone!"


func _set_rub_label():
	_rub_label.text = "Percent Rubbed: %d%%" % ScoreKeeper.percent_rubbed


func _on_leave_scene_timer_timeout():
	get_tree().call_deferred("change_scene_to_file", "res://world/world.tscn")
