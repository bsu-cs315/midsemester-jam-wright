extends Node2D


func _on_start_button_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://world/world.tscn")
