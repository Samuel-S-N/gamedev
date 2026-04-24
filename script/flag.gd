extends Area2D
@export var next_level: PackedScene

func _on_area_entered(area: Area2D) -> void:

	if area.get_parent().is_in_group("player"):
		
		var collected = Global.score - Global.saved_score
		
		var record = {
			"collected_fruits": collected,
			"total_fruits": Global.current_total_fruits,
			"time": Global.current_time_str
		}
		
		Global.level_records.append(record)
		
		Global.saved_score = Global.score
		get_tree().call_deferred("change_scene_to_packed", next_level)

	pass
