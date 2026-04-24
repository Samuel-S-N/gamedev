extends Label

var fruits_total = 0

func _ready() -> void:
	
	fruits_total = get_tree().get_nodes_in_group("fruit").size()
	
pass

func _process(delta: float) -> void:
	
	var collected = Global.score - Global.saved_score
	
	text = str(collected) + "/" + str(fruits_total)
	
pass
