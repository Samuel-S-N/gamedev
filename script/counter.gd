extends Label

var fruits_total = 0

func _ready() -> void:
	
	fruits_total = get_tree().get_nodes_in_group("fruit").size()
	
pass

func _process(delta: float) -> void:
	
	var collected = Global.score - Global.saved_score
	var total_in_level = fruits_total + collected
	
	text = str(collected) + "/" + str(fruits_total)
	
	Global.current_total_fruits = total_in_level
	
pass
