extends Label

var time: float = 0.0

func _process(delta: float) -> void:
	
	if not Global.restart:
		time += delta
	
	var minutes = int(time) / 60
	var seconds = int(time) % 60
	var millis = int((time - int(time)) * 100)
	
	text = "%02d:%02d:%02d" % [minutes, seconds, millis]
	
	Global.current_time_str = text
	
pass
