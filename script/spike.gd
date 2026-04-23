extends Area2D




func _on_area_entered(area: Area2D) -> void:
	
	if area.get_parent().is_in_group("player"):
		area.get_parent().die()
	
	
	pass # Replace with function body.
