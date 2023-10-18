extends Node2D


@onready var music : AudioStreamPlayer = $Music


func _ready() -> void:
	# Fade in the music
	music.set_volume_db(-10)
	var tween := create_tween()
	tween.tween_property(music, "volume_db", 0, .5)


func _on_frog_mash_requested() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://world/mash_world/mash_world.tscn")


#WHATS LEFT?
# sound effects / music---DONE
# title and end screen---DONE
# background---DONE

#THE JUICE:
# wiggle as timer goes down
# nose pops off---DONE
# animate frog baby 
