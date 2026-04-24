extends Control

@onready var label_stats = $HUD/score

var final_text = ""


func _ready() -> void:
	
	#var final_text = "Finished!\n"
	
	for i in range(Global.level_records.size()):
		var record = Global.level_records[i]
		
		final_text += "Level " + str(i + 1) + ":\n"
		final_text += "Fruits: " + str(record["collected_fruits"]) + "/" + str(record["total_fruits"]) + "\n"
		final_text += record["time"] + "\n\n"
		
	label_stats.text = final_text
	
pass


func _on_reset_pressed() -> void:
	
	Global.score = 0
	Global.saved_score = 0
	Global.level_records.clear()
	Global.p2_joined = false
	
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")
	
	pass
