extends Node2D


@onready var _music : AudioStreamPlayer = $Music
@onready var _spawn_points := $SpawnPoints.get_children()

func _ready() -> void:
	# Fade in the music
	_music.set_volume_db(-10)
	var tween := create_tween()
	tween.tween_property(_music, "volume_db", 0, .5)
	$FrogBaby.global_position = _spawn_points.pick_random().global_position


func _on_frog_mash_requested() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://world/mash_world/mash_world.tscn")

