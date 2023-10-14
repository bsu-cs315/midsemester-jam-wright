extends Node2D




func _on_frog_mash_requested():
	get_tree().call_deferred("change_scene_to_file", "res://world/mash_world.tscn")
