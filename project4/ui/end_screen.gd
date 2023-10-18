extends Node2D


func _on_title_button_pressed() -> void:
 get_tree().call_deferred("change_scene_to_file", "res://ui/title_screen.tscn")
